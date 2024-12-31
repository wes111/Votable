//
//  MembershipService+Preview.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/20/24.
//

import Foundation
import SharedResourcesClientAndServer

struct MembershipServiceMock: MembershipService {
    func setup() async throws { }
    
    func fetchMemberships() async throws -> [Membership] {
        [Membership.preview]
    }
    
    func createMembership(in community: SharedResourcesClientAndServer.Community) async throws -> Membership {
        .preview
    }
    
    func deleteMembership(_ membership: SharedResourcesClientAndServer.Membership) async throws { }
}
