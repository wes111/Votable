//
//  CommunityNameViewModel+Preview.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import Foundation

extension CommunityInputFlowViewModel {
    static func preview(flowPath: CommunityFlow = .name) -> CommunityInputFlowViewModel {
        CommunityInputFlowViewModel(coordinator: .preview, flowPath: flowPath, input: .preview)
    }
}

extension CommunityNameViewModel {
    static let preview = CommunityNameViewModel(flowCoordinator: .preview())
}

extension CommunityTaglineViewModel {
    static let preview = CommunityTaglineViewModel(flowCoordinator: .preview())
}

extension CommunitySettingsViewModel {
    static let preview = CommunitySettingsViewModel(flowCoordinator: .preview())
}

extension CommunityCategoriesViewModel {
    static let preview = CommunityCategoriesViewModel(flowCoordinator: .preview())
}

extension CommunityTagsViewModel {
    static let preview = CommunityTagsViewModel(flowCoordinator: .preview())
}

extension CommunityRulesViewModel {
    static let preview = CommunityRulesViewModel(flowCoordinator: .preview())
}

extension CommunityResourcesViewModel {
    static let preview = CommunityResourcesViewModel(flowCoordinator: .preview())
}

extension CommunityDescriptionViewModel {
    static let preview = CommunityDescriptionViewModel(flowCoordinator: .preview())
}
