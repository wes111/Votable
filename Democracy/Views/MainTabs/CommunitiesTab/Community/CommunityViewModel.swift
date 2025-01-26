//
//  CommunityViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/26/23.
//

import Combine
import Factory
import Foundation
import SharedSwiftUI
import SharedResourcesClientAndServer

@MainActor @Observable
final class CommunityViewModel {
    var isShowingProgress: Bool = false
    var membership: Membership?
    var selectedTab: CommunityTab = .feed
    let community: Community
    
    @ObservationIgnored @Injected(\.membershipService) private var membershipService
    @ObservationIgnored @Injected(\.membershipAsyncStreamManager) private var membershipStreamManager
    
    init(community: Community) {
        self.community = community
        
        startMembershipsTask()
    }
}

// MARK: - Computed Properties
extension CommunityViewModel {
    
    var membershipButtonTitle: String {
        membership == nil ? "Join" : "Leave"
    }
    
    var membersText: String {
        "\(community.memberCount.delimiter) members"
    }
    
    var foundedText: String {
        "Founded - \(community.creationDate.getFormattedDate(format: .ddMMMyyyy))"
    }
}

// MARK: - Methods
extension CommunityViewModel {
    
    @StorageActor
    func toggleCommunityMembership() async {
        do {
            if let membership = await membership {
                try await membershipService.deleteMembership(membership)
            } else {
                _ = try await membershipService.createMembership(in: community)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

// MARK: - Private Methods
private extension CommunityViewModel {
    func startMembershipsTask() {
        Task {
            membership = await (membershipStreamManager.currentValue ?? []).first(where: { $0.community == community })
            for await membershipsArray in await membershipStreamManager.stream() {
                membership = (membershipsArray ?? []).first(where: { $0.community == community })
            }
        }
    }
}
