//
//  CommunitiesTabMainViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/23.
//

import Combine
import Foundation
import Factory
import SharedResourcesClientAndServer

@MainActor @Observable
final class CommunitiesTabMainViewModel {
    @Injected(\.membershipService) @ObservationIgnored private var membershipService
    @Injected(\.communityService) @ObservationIgnored private var communityService
    @Injected(\.membershipAsyncStreamManager) @ObservationIgnored private var membershipStreamManager
    
    var allCommunities: [Community] = []
    var category: CommunitiesCategory = .isMemberOf
    var isShowingProgress: Bool = true
    var fetchCommunitiesTask: Task<Void, Never>?
    
    private weak var coordinator: CommunitiesCoordinatorDelegate?
    
    init(coordinator: CommunitiesCoordinatorDelegate?) {
        self.coordinator = coordinator
        startMembershipsTask() // TODO: Should be in task modifier...
    }
}

// MARK: - Methods
extension CommunitiesTabMainViewModel {
    
    func goToCommunity(_ community: Community) {
        coordinator?.goToCommunity(community: community)
    }
    
    func showCreateCommunityView() {
        coordinator?.showCreateCommunityView()
    }
    
    func onAppear() {
        fetchCommunitiesByCategory(category)
    }
    
    func forceRefreshMemberships() async {
        do {
            _ = try await membershipService.fetchMemberships()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchCommunitiesByCategory(_ category: CommunitiesCategory) {
        fetchCommunitiesTask?.cancel()
        allCommunities = []
        
        fetchCommunitiesTask = Task {
            isShowingProgress = true
            do {
                try await Task.sleep(nanoseconds: 2_000_000_000)
                switch category {
                case .isMemberOf:
                    allCommunities = await (membershipStreamManager.currentValue ?? []).map { $0.community }
                    
                case .isLeaderOf:
                    break // TODO: ...
                case .topCommunities:
                    break // TODO: ...
                case .random:
                    break // TODO: ...
                case .recommendations:
                    allCommunities = try await communityService.fetchAllCommunities()
                }
            } catch {
                // Note: Cannot present an alert here, because cancelling a task (by selecting a different
                // category) will throw an error.
                print(error.localizedDescription)
            }
            isShowingProgress = false
        }
    }
}

// MARK: - Private Methods
private extension CommunitiesTabMainViewModel {
    func startMembershipsTask() {
        Task {
            for await membershipsArray in await membershipStreamManager.stream() {
                allCommunities = (membershipsArray ?? []).map { $0.community }
            }
        }
    }
}
