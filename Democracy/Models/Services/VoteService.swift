//
//  VoteService.swift
//  Democracy
//
//  Created by Wesley Luntsford on 6/29/24.
//

import Factory
import Foundation
import DemocracySwiftUI
import SharedResourcesClientAndServer

enum VoteServiceError: Error {
    case unhandledVotable
    case reverseFailed
}

@StorageActor
protocol VoteService: Sendable {
    func voteOnObject<T: Votable>(_ object: T, vote: VoteType) async throws -> T.Vote
    
    nonisolated init()
}

struct VoteServiceDefault: VoteService {
    @Injected(\.votableBackendDataService) private var votableBackendDataService
    
    func voteOnObject<T: Votable>(_ object: T, vote: VoteType) async throws -> T.Vote {
        let originalVote = object.userVote?.vote
        updateVoteCountsOnObject(object, newVote: vote, originalVote: originalVote)
        updateUserVoteOnObject(object, newVote: vote)
        
        do {
            let userVote = try await voteOnObjectInRepository(object, vote: vote)
            object.userVote = userVote
            return userVote
        } catch {
            updateVoteCountsOnObject(object, newVote: vote, originalVote: originalVote, isReversal: true)
            try reverseUserVoteOnObject(object, originalVote: originalVote)
            throw error
        }
    }
}

// MARK: - Private Methods
private extension VoteServiceDefault {
    
    func updateVoteCountsOnObject<T: Votable>(
        _ object: T,
        newVote: VoteType,
        originalVote: VoteType?,
        isReversal: Bool = false
    ) {
        let increment: Int = !isReversal ? 1 : -1
        
        if let originalVote {
            if originalVote == newVote {
                switch originalVote { // Removing previous vote.
                case .up:
                    object.upVoteCount -= increment
                case .down:
                    object.downVoteCount -= increment
                }
            } else {
                switch newVote { // Switching vote.
                case .up:
                    object.upVoteCount += increment
                    object.downVoteCount -= increment
                case .down:
                    object.downVoteCount += increment
                    object.upVoteCount -= increment
                }
            }
        } else { // Adding a new vote.
            switch newVote {
            case .up:
                object.upVoteCount += increment
            case .down:
                object.downVoteCount += increment
            }
        }
    }
    
    func voteOnObjectInRepository<T: Votable>(_ object: T, vote: VoteType) async throws -> T.Vote {
        if let object = object as? ObservableComment {
            return try await votableBackendDataService.voteOnComment(request: .init(commentId: object.id, userId: object.userId, vote: vote)) as! T.Vote
        } else if let object = object as? ObservablePost {
            return try await votableBackendDataService.voteOnPost(request: .init(postId: object.id, userId: object.userId, vote: vote)) as! T.Vote
        } else {
            throw VoteServiceError.unhandledVotable
        }
    }
    
    func updateUserVoteOnObject<T: Votable>(_ object: T, newVote: VoteType) {
        if let userVote = object.userVote {
            if userVote.vote == newVote {
                object.userVote?.vote = nil
            } else {
                object.userVote?.vote = newVote
            }
        } else {
            object.userVote = T.Vote.createTempVote()
        }
    }
    
    func reverseUserVoteOnObject<T: Votable>(_ object: T, originalVote: VoteType?) throws {
        guard let userVote = object.userVote else {
            throw VoteServiceError.reverseFailed
        }
        
        if userVote.id == "temp" {
            object.userVote = nil
        } else {
            object.userVote?.vote = originalVote
        }
    }
}
