//
//  CommunityCardViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/3/24.
//

import Foundation
import Factory
import SharedResourcesClientAndServer

@MainActor @Observable
final class CommunityCardViewModel {
    let community: Community
    @ObservationIgnored @Injected(\.membershipService) private var membershipService
    
    init(community: Community) {
        self.community = community
    }
}

// MARK: - Computed Properties
extension CommunityCardViewModel {
    
    var name: String {
        community.name
    }
    
    var tagline: String {
        community.tagline
    }
    
    var membershipButtonTitle: String {
        "Join"
        //membership == nil ? "Join" : "Leave"
    }
}

// MARK: - Methods
extension CommunityCardViewModel {
    
    func toggleCommunityMembership() async {
        try? await Task.sleep(nanoseconds: 150_000_000)
        // TODO: we should ask membershipService to toggle membership....
//        do {
//            if let membership {
//                try await membershipService.leaveCommunity(membership: membership)
//            } else {
//                try await membershipService.joinCommunity(community)
//            }
//        } catch {
//            print(error.localizedDescription)
//        }
    }
}
