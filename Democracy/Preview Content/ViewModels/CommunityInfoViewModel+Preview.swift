//
//  CommunityInfoViewModel+Preview.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/20/23.
//

import Foundation
import SharedResourcesClientAndServer

extension CommunityInfoViewModel {
    static let preview = CommunityInfoViewModel(
        coordinator: CommunitiesCoordinator.preview, community: Community.preview
    )
}
