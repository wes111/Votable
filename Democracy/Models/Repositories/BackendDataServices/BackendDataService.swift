//
//  BackendDataService.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/20/24.
//

import Factory
import Foundation
import SharedResourcesClientAndServer

// Used to abstract-out Appwrite dependency.
// This is ultimately what Appwrite protocol will need to be....
@StorageActor
protocol BackendDataService {
    associatedtype CreationRequest: Creatable
    
    nonisolated init()

    var appwriteService: AppwriteService { get }
    
    func createObject(request: CreationRequest) async throws -> CreationRequest.ResponseModel.DomainModel
    func fetch(queries: [AppwriteQuery]) async throws -> [CreationRequest.ResponseModel.DomainModel]
    func deleteObject(_ objectId: String) async throws
}

extension BackendDataService {
    func createObject<CreationRequest: Creatable>(request: CreationRequest) async throws -> CreationRequest.ResponseModel.DomainModel {
        try await appwriteService.createObject(request: request)
    }
    
    func fetch(queries: [AppwriteQuery]) async throws -> [CreationRequest.ResponseModel.DomainModel] {
        try await appwriteService.fetch(queries: queries, type: CreationRequest.ResponseModel.self)
    }
    
    func deleteObject(_ objectId: String) async throws {
        try await appwriteService.deleteObject(objectId, collection: CreationRequest.ResponseModel.collection)
    }
}
