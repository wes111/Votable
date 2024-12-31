//
//  CommentBackendDataService.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/11/24.
//

import Factory
import Foundation
import SharedResourcesClientAndServer

@StorageActor
protocol CommentBackendDataService: BackendDataService {
    func fetch(queries: [AppwriteQuery]) async throws -> [Comment]
}

struct CommentBackendDataServiceDefault: CommentBackendDataService {
    typealias CreationRequest = CommentCreationRequest
    
    @Injected(\.appwriteService) var appwriteService
}
