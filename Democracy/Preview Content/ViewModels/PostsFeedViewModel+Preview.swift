//
//  CommunityHomeFeedViewModel+Preview.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/10/23.
//

import Foundation
import SharedResourcesClientAndServer

extension PostsFeedViewModel {
    static let preview = PostsFeedViewModel(
        community: .preview,
        postFilters: .init()
    )
}
