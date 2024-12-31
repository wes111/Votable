//
//  VotableBackendDataService.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/12/24.
//

import Factory
import Foundation
import SharedResourcesClientAndServer

@StorageActor
protocol VotableBackendDataService {
    func voteOnComment(request: CommentVoteRequest) async throws -> CommentVote
    func voteOnPost(request: PostVoteRequest) async throws -> PostVote
    
    nonisolated init()
}

struct VotableBackendDataServiceDefault: VotableBackendDataService {
    @Injected(\.appwriteService) var appwriteService
    
    func voteOnComment(request: CommentVoteRequest) async throws -> CommentVote {
        try await appwriteService.callCustomFunction(request: request)
    }
    
    func voteOnPost(request: PostVoteRequest) async throws -> PostVote {
        try await appwriteService.callCustomFunction(request: request)
    }
}
