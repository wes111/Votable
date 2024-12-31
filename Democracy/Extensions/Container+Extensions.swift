//
//  Container+Extensions.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/11/23.
//

import Foundation
import Factory
import SharedResourcesClientAndServer

// MARK: - Services
extension Container {
    
    var appwriteService: Factory<AppwriteService> {
        self { AppwriteServiceDefault() }
    }
    
    var richLinkService: Factory<RichLinkServiceProtocol> {
        self { RichLinkService() }
    }
    
    var postService: Factory<PostService> {
        self { PostServiceDefault() }.scope(.shared)
    }
    
    var communityService: Factory<CommunityService> {
        self { CommunityServiceDefault() }.scope(.shared)
    }
    
    var membershipService: Factory<MembershipService> {
        self { MembershipServiceDefault() }.scope(.shared)
    }
    
    var commentService: Factory<CommentService> {
        self { CommentServiceDefault() }.scope(.shared)
    }
    
    var voteService: Factory<VoteService> {
        self { VoteServiceDefault() }.scope(.shared)
    }
    
    var userService: Factory<UserService> {
        self { UserServiceDefault() }.scope(.shared)
    }
    
    var sessionService: Factory<SessionService> {
        self { SessionServiceDefault() }.scope(.shared)
    }
}

// MARK: - BackendDataServices
extension Container {
    
    var communityBackendDataService: Factory<any CommunityBackendDataService> {
        self { CommunityBackendDataServiceDefault() }.scope(.shared)
    }
    
    var postBackendDataService: Factory<any PostBackendDataService> {
        self { PostBackendDataServiceDefault() }.scope(.shared)
    }
    
    var userBackendDataService: Factory<any UserBackendDataService> {
        self { UserBackendDataServiceDefault() }.scope(.shared)
    }
    
    var commentBackendDataService: Factory<any CommentBackendDataService> {
        self { CommentBackendDataServiceDefault() }.scope(.shared)
    }
    
    var sessionBackendDataService: Factory<any SessionBackendDataService> {
        self { SessionBackedDataServiceDefault() }.scope(.shared)
    }
    
    var membershipBackendDataService: Factory<any MembershipBackendDataService> {
        self { MembershipBackendDataServiceDefault() }.scope(.shared)
    }
    
    var votableBackendDataService: Factory<any VotableBackendDataService> {
        self { VotableBackendDataServiceDefault() }.scope(.shared)
    }
}

// MARK: - StreamManagers
extension Container {
    
    var communityAsyncStreamManager: Factory<AsyncStreamManager<[Community]>> {
        self { AsyncStreamManager() }.scope(.shared)
    }
    
    var userAsyncStreamManager: Factory<AsyncStreamManager<User>> {
        self { AsyncStreamManager() }.scope(.shared)
    }
    
    var sessionAsyncStreamManager: Factory<AsyncStreamManager<Session>> {
        self { AsyncStreamManager() }.scope(.shared)
    }
    
    var membershipAsyncStreamManager: Factory<AsyncStreamManager<[Membership]>> {
        self { AsyncStreamManager() }.scope(.shared)
    }
}
