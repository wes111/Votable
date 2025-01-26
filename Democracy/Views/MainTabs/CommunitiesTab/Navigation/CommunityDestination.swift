//
//  CommunitiesTabPath.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/31/23.
//

import Navigator
import SharedResourcesClientAndServer
import SwiftUI

enum CommunityDestination {
    case communityHome(Community)
    case communityPost(Post)
    case communityCandidates
    case communityCandidate(Candidate)
    case communityPostCategory(filters: PostFilters, community: Community)
    case communityVote
    case createCandidate
    case createCommunity
    case createPost(community: Community)
}

extension CommunityDestination: NavigationDestination {
    var view: some View {
        switch self {
        case .communityHome(let community):
            CommunityView(community: community)
            
        case .communityPost(let post):
            PostView(post: post)
            
        case .communityCandidates:
            CandidatesView()
            
        case .communityCandidate(let candidate):
            CandidateView(candidate: candidate)
            
        case .communityPostCategory(let filters, let community):
            FilterablePostsFeedView(community: community, filters: filters)
            
        case .communityVote:
            EmptyView()
            
        case .createCandidate:
            EmptyView()
            
        case .createCommunity:
            CreateCommunityCoordinatorView()
            
        case .createPost(let community):
            CreatePostCoordinatorView(community: community)
        }
    }
    
    var method: NavigationMethod {
        switch self {
        case .communityHome, .communityPost, .communityCandidates, .communityCandidate, .communityPostCategory, .communityVote:
                .push
        case .createCandidate, .createCommunity, .createPost:
                .cover
        }
    }
}
