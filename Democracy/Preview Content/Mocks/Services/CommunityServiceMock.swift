//
//  CommunityService+Preview.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/20/24.
//

import Foundation
import SharedResourcesClientAndServer

final class CommunityServiceMock: CommunityService {
    func createCommunity(from userInput: CommunityCreationRequestBuilder) async throws -> Community {
        .preview
    }
    
    func isCommunityNameAvailable(_ name: CommunityName) async throws -> Bool {
        true
    }
    
    func fetchAllCommunities() async throws -> [Community] {
        []
    }
}
