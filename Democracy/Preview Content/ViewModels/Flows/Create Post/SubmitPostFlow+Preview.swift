//
//  PostInputFlowViewModel+Preview.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/9/24.
//

import Foundation
import SharedResourcesClientAndServer

extension PostInputFlowViewModel {
    static func preview(flowPath: PostFlow = .title) -> PostInputFlowViewModel {
        PostInputFlowViewModel(community: .preview, flowPath: flowPath)
    }
}

extension PostTagsViewModel {
    static let preview = PostTagsViewModel(flowCoordinator: .preview())
}

extension PostCategoryViewModel {
    static let preview = PostCategoryViewModel(flowCoordinator: .preview())
}

extension PostPrimaryLinkViewModel {
    static let preview = PostPrimaryLinkViewModel(flowCoordinator: .preview())
}

extension PostTitleViewModel {
    static let preview = PostTitleViewModel(flowCoordinator: .preview())
}

extension PostBodyViewModel {
    static let preview = PostBodyViewModel(flowViewModel: .preview())
}
