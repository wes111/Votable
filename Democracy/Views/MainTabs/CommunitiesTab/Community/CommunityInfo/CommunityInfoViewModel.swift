//
//  CommunityInfoViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/20/23.
//

import Factory
import Foundation
import SharedResourcesClientAndServer

@MainActor @Observable
final class CommunityInfoViewModel {
    let community: Community
    var isShowingProgress: Bool = false
    
    init(community: Community) {
        self.community = community
    }
}

// MARK: - Computed Properties
extension CommunityInfoViewModel {
    var description: String {
        community.descriptionText
    }
    
    var alliedCommunities: [Community] {
        Community.myCommunitiesPreviewArray // TODO: ...
    }
    
    var rules: [Rule] {
        community.rules
    }
    
    var resources: [Resource] {
        community.resources
    }
    
    var candidates: [Candidate] { // TODO: This view should have reps, not candidates....
        Candidate.previewArray
    }
    
//    var leaders: [Leader] {
//        [] // TODO: ...
//    }
}
