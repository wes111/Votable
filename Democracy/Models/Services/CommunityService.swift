//
//  CommunityService.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/28/24.
//

import Factory
import Foundation
import SharedResourcesClientAndServer

@StorageActor
protocol CommunityService: Sendable {
    func createCommunity(from userInput: CommunityCreationRequestBuilder) async throws -> Community
    func isCommunityNameAvailable(_ name: CommunityName) async throws -> Bool
    func fetchAllCommunities() async throws -> [Community]
    
    nonisolated init()
}

struct CommunityServiceDefault: CommunityService {
    @Injected(\.communityBackendDataService) private var communityBackendDataService
    @Injected(\.communityAsyncStreamManager) private var communityStreamManager
    @Injected(\.userAsyncStreamManager) private var userStreamManager
    
    func createCommunity(from userInput: CommunityCreationRequestBuilder) async throws -> Community {
        guard let user = userStreamManager.currentValue else {
            throw GenericError.missingUser
        }
        let creationRequest = try await userInput.build(userId: user.id)
        return try await communityBackendDataService.createObject(request: creationRequest)
    }
    
    func fetchAllCommunities() async throws -> [Community] {
        let communities: [Community] = try await communityBackendDataService.fetch(queries: [])
        communityStreamManager.yield(communities)
        return communities
    }
    
    func isCommunityNameAvailable(_ name: CommunityName) async throws -> Bool {
        try await communityBackendDataService.fetch(queries: [
            .equal(key: CommunityAttribute.id.key, value: name.value)
        ]).isEmpty
    }
}
