//
//  AppwriteService.swift
//  Democracy
//
//  Created by Wesley Luntsford on 9/27/23.
//

@preconcurrency import Appwrite
import AppwriteEnums
import Foundation
import SharedResourcesClientAndServer

extension FunctionMethod {
    func toExecutionMethod() -> ExecutionMethod {
        return switch self {
        case .get: .gET
        case .post: .pOST
        case .put: .pUT
        case .patch: .pATCH
        case .delete: .dELETE
        case .options: .oPTIONS
        }
    }
}

enum AppwriteServiceError: Error {
    case unsuccessfulDeletion
}

@StorageActor 
protocol AppwriteService {
    func createUser(userName: Username, password: Password, email: Email) async throws -> SharedResourcesClientAndServer.User
    func createSession(email: Email, password: Password) async throws -> SharedResourcesClientAndServer.Session
    func deleteSession(sessionId: String) async throws
    func getCurrentSession() async throws -> SharedResourcesClientAndServer.Session
    func updatePhone(phone: PhoneNumber, password: Password) async throws -> SharedResourcesClientAndServer.User
    func getCurrentLoggedInUser() async throws -> SharedResourcesClientAndServer.User
    
    // GENERIC
    func createObject<CreationRequest: Creatable>(request: CreationRequest) async throws -> CreationRequest.ResponseModel.DomainModel
    func fetch<T: DomainConvertible>(queries: [AppwriteQuery], type: T.Type) async throws -> [T.DomainModel]
    func callCustomFunction<Request: FunctionCreatable>(request: Request) async throws -> Request.ResponseModel.DomainModel
    func deleteObject(_ objectId: String, collection: Collection) async throws
    
    nonisolated init()
}

final class AppwriteServiceDefault: AppwriteService {
    private let projectEndpoint = "http://10.0.0.99/v1"
    private let projectID = "demo"
    
    private lazy var databases: Databases = { Databases(client) }()
    private lazy var account: Account = { Account(client) }()
    private lazy var functions: Functions = { Functions(client) }()
    
    private lazy var client: Client = {
        Client()
            .setEndpoint(projectEndpoint)
            .setProject(projectID)
            .setSelfSigned(true) // For self signed certificates, only use for development
    }()
    
    init() {}
}

// MARK: - Methods
extension AppwriteServiceDefault {
    
    func createUser(userName: Username, password: Password, email: Email) async throws -> SharedResourcesClientAndServer.User {
        return try await account.create(userId: userName.value,email: email.value,password: password.value).toUser()
    }
    
    func createSession(email: Email, password: Password) async throws -> SharedResourcesClientAndServer.Session {
        try await account.createEmailPasswordSession(email: email.value, password: password.value).toSession()
    }
    
    func deleteSession(sessionId: String) async throws {
        _ = try await account.deleteSession(sessionId: sessionId)
    }
    
    func getCurrentSession() async throws -> SharedResourcesClientAndServer.Session {
        try await account.getSession(sessionId: "current").toSession()
    }
    
    func updatePhone(phone: PhoneNumber, password: Password) async throws -> SharedResourcesClientAndServer.User {
        try await account.updatePhone(phone: phone.appwriteString, password: password.value).toUser()
    }
    
    func getCurrentLoggedInUser() async throws -> SharedResourcesClientAndServer.User {
        try await account.get().toUser()
    }
}

// MARK: - Post/Database Methods
extension AppwriteServiceDefault {
    
    func deleteObject(_ objectId: String, collection: Collection) async throws {
        let wasSuccessful = try await databases.deleteDocument(
            databaseId: Database.id,
            collectionId: collection.id,
            documentId: objectId
        )
        guard let wasSuccessful = wasSuccessful as? Bool, wasSuccessful else {
            throw AppwriteServiceError.unsuccessfulDeletion
        }
    }
    
    func createObject<CreationRequest: Creatable>(request: CreationRequest) async throws -> CreationRequest.ResponseModel.DomainModel {
        let document = try await databases.createDocument(
            databaseId: Database.id,
            collectionId: CreationRequest.ResponseModel.collection.id,
            documentId: request.creationId ?? ID.unique(),
            data: try request.toDictionary()
        )
        return try CreationRequest.ResponseModel(document.data.toDictionary()).toDomain()
    }
    
    func callCustomFunction<Request: FunctionCreatable>(request: Request) async throws -> Request.ResponseModel.DomainModel {
        let jsonString = try request.toJSONString()
        let execution = try await functions.createExecution(
            functionId: request.function.id,
            body: jsonString,
            method: request.function.method.toExecutionMethod()
        )
        let responseModel: Request.ResponseModel = try execution.responseBody.decode()
        return responseModel.toDomain()
    }
    
    func fetch<T: DomainConvertible>(queries: [AppwriteQuery], type: T.Type) async throws -> [T.DomainModel] {
        let queries: [String] = queries.map { query in
            switch query {
                
            case .equal(let key, let value):
                Query.equal(key, value: value)
                
            case .limit(let value):
                Query.limit(value)
                
            case .isNull(let key):
                Query.isNull(key)
                
            case .isNotNull(let key):
                Query.isNotNull(key)
                
            case .cursorAfter(let id):
                Query.cursorAfter(id)
                
            case .cursorBefore(let id):
                Query.cursorBefore(id)
                
            case .greaterThanEqual(let key, let date):
                Query.greaterThanEqual(key, value: date.ISO8601Format())
                
            case .contains(let key, let values):
                Query.contains(key, value: values)
                
            case .orderAscending(let key):
                Query.orderAsc(key)
                
            case .orderDescending(let key):
                Query.orderDesc(key)
            }
        }
        
        let documentList = try await databases.listDocuments(
            databaseId: Database.id,
            collectionId: T.collection.id,
            queries: queries
        )
        
        return try documentList.documents.map { try T($0.data.toDictionary()).toDomain() }
    }
}
