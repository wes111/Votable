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
    private weak var coordinator: CommunitiesCoordinatorDelegate?
    let community: Community
    
    @ObservationIgnored @Injected(\.membershipService) private var membershipService
    @ObservationIgnored @Injected(\.membershipAsyncStreamManager) private var membershipStreamManager
    
    init(coordinator: CommunitiesCoordinatorDelegate, community: Community) {
        self.coordinator = coordinator
        self.community = community
        
        startMembershipsTask()
    }
}

// MARK: - Computed Properties
extension CommunityViewModel {
    
    var leadingContent: [TopBarContent] {
        [.back(goBack)]
    }
    
    var centerContent: [TopBarContent] {
       [] // [.title(community.name, size: .large)]
    }
    
    var trailingContent: [TopBarContent] {
        [.menu([
            .init(title: "Create Post", action: showCreatePostView)
        ])]
    }
    
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
    
    func showCreatePostView() {
        coordinator?.showCreatePostView(for: community)
    }
    
    func communityHomeFeedViewModel() -> PostsFeedViewModel {
        PostsFeedViewModel(community: community, postFilters: .init(), coordinator: coordinator)
    }
    
    func communityInfoViewModel() -> CommunityInfoViewModel {
        CommunityInfoViewModel(coordinator: coordinator, community: community)
    }
    
    func communityArchiveViewModel() -> CommunityArchiveViewModel {
        .init(community: community, coordinator: coordinator)
    }
    
    func goBack() {
        coordinator?.goBack()
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
