//
//  MembershipService.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/24/24.
//

import Factory
import Foundation
import SharedResourcesClientAndServer
import SharedSwift

@StorageActor
protocol MembershipService: Sendable {
    func setup() async throws
    func fetchMemberships() async throws -> [Membership]
    func createMembership(in community: Community) async throws -> Membership
    func deleteMembership(_ membership: Membership) async throws
    
    nonisolated init()
}

struct MembershipServiceDefault: MembershipService {
    @Injected(\.membershipBackendDataService) private var membershipBackendDataService
    @Injected(\.membershipAsyncStreamManager) private var membershipStreamManager
    @Injected(\.userAsyncStreamManager) private var userStreamManager
    
    func setup() async throws {
        _ = try await fetchMemberships()
    }
    
    func fetchMemberships() async throws -> [Membership] {
        guard let user = userStreamManager.currentValue else {
            throw GenericError.missingUser
        }
        let memberships = try await membershipBackendDataService.fetch(queries: [
            .equal(key: MembershipAttribute.userId.key, value: user.id)
        ])
        membershipStreamManager.yield(memberships)
        return memberships
    }
    
    func createMembership(in community: Community) async throws -> Membership {
        guard let user = userStreamManager.currentValue else {
            throw GenericError.missingUser
        }
        let newMembership = try await membershipBackendDataService.createObject(request: MembershipCreationRequest(userId: user.id, communityId: community.id))
        var memberships = membershipStreamManager.currentValue ?? []
        memberships.append(newMembership)
        membershipStreamManager.yield(memberships)
        return newMembership
    }
    
    func deleteMembership(_ membership: Membership) async throws {
        var memberships = membershipStreamManager.currentValue ?? []
        memberships.removeAll(where: { $0.id == membership.id })
        try await membershipBackendDataService.deleteObject(membership.id)
        membershipStreamManager.yield(memberships)
    }
}
