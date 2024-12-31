//
//  CommunityBackendDataService.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/4/24.
//

import Factory
import Foundation
import SharedResourcesClientAndServer

@StorageActor
protocol CommunityBackendDataService: BackendDataService {
    func fetch(queries: [AppwriteQuery]) async throws -> [Community]
}

struct CommunityBackendDataServiceDefault: CommunityBackendDataService {
    typealias CreationRequest = CommunityCreationRequest
    
    @Injected(\.appwriteService) var appwriteService
}


