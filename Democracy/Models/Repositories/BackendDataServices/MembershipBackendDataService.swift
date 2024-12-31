//
//  MembershipBackendDataService.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/12/24.
//

import Factory
import Foundation
import SharedResourcesClientAndServer

@StorageActor
protocol MembershipBackendDataService: BackendDataService {
    func fetch(queries: [AppwriteQuery]) async throws -> [Membership]
}

struct MembershipBackendDataServiceDefault: MembershipBackendDataService {
    typealias CreationRequest = MembershipCreationRequest
    
    @Injected(\.appwriteService) var appwriteService
}
