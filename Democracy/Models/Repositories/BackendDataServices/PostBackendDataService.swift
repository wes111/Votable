//
//  PostBackendDataService.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/10/24.
//

import Factory
import Foundation
import SharedResourcesClientAndServer

@StorageActor
protocol PostBackendDataService: BackendDataService {
    func fetch(queries: [AppwriteQuery]) async throws -> [Post]
}

struct PostBackendDataServiceDefault: PostBackendDataService {
    typealias CreationRequest = PostCreationRequest
    
    @Injected(\.appwriteService) var appwriteService
}
