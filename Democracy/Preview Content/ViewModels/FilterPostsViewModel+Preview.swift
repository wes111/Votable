//
//  FilterPostsViewModel+Preview.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/21/24.
//

import DemocracySwiftUI
import Foundation
import SharedResourcesClientAndServer

extension FilterPostsViewModel {
    static var preview: FilterPostsViewModel {
        .init(
            communityTags: Community.preview.tags.map { SelectableCommunityTag(communityTag: $0) },
            postFilters: .preview, onUpdateFilters: { _ in }
        )
    }
}
