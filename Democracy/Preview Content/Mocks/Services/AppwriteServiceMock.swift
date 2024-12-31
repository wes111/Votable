//
//  AppwriteService+Preview.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/20/24.
//

import Foundation
import SharedResourcesClientAndServer

final class AppwriteServiceMock: AppwriteService {
    func createUser(userName: Username, password: Password, email: Email) async throws -> User {
        .preview
    }
    
    func createSession(email: Email, password: Password) async throws -> Session {
        .preview
    }
    
    func deleteSession(sessionId: String) async throws { }
    
    func updatePhone(phone: PhoneNumber, password: Password) async throws -> User {
        .preview
    }
    
    func createObject<CreationRequest>(request: CreationRequest) async throws -> CreationRequest.ResponseModel.DomainModel where CreationRequest : Creatable {
        let dictionary: [String:String] = [:]
        return try CreationRequest.ResponseModel(dictionary).toDomain()
    }
    
    func fetch<T>(queries: [AppwriteQuery], type: T.Type) async throws -> [T.DomainModel] where T : DomainConvertible {
        let dictionary: [String:String] = [:]
        return [ try T(dictionary).toDomain()]
    }
    
    func callCustomFunction<Request>(request: Request) async throws -> Request.ResponseModel.DomainModel where Request : FunctionCreatable {
        let response: String = ""
        let responseModel: Request.ResponseModel = try response.decode()
        return responseModel.toDomain()
    }
    
    func deleteObject(_ objectId: String, collection: Collection) async throws { }
    
    func getCurrentSession() async throws -> Session {
        .preview
    }
    
    func getCurrentLoggedInUser() async throws -> User {
        .preview
    }
}
