//
//  CommunityInputFlowView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/10/24.
//

import SwiftUI

@MainActor
struct CommunityInputFlowView: View {
    @Bindable var viewModel: CommunityInputFlowViewModel
    
    init(viewModel: CommunityInputFlowViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        flowScren
            .animation(.easeInOut, value: viewModel.flowPath)
            .progressModifier(isShowingProgess: $viewModel.isShowingProgress)
            .alertableModifier(alertModel: $viewModel.alertModel)
    }
}

// MARK: - Subviews
private extension CommunityInputFlowView {
    @ViewBuilder
    var flowScren: some View {
        InputFlowView(viewModel: viewModel) {
            switch viewModel.flowPath {
            case .name:
                CommunityNameView(viewModel: .init(flowCoordinator: viewModel))
            case .tagline:
                CommunityTaglineView(viewModel: .init(flowCoordinator: viewModel))
            case .description:
                CommunityDescriptionView(viewModel: .init(flowCoordinator: viewModel))
            case .categories:
                CommunityCategoriesView(viewModel: .init(flowCoordinator: viewModel))
            case .tags:
                CommunityTagsView(viewModel: .init(flowCoordinator: viewModel))
            case .rules:
                CommunityRulesView(viewModel: .init(flowCoordinator: viewModel))
            case .settings:
                CommunitySettingsView(viewModel: .init(flowCoordinator: viewModel))
            case .resources:
                CommunityResourcesView(viewModel: .init(flowCoordinator: viewModel))
            }
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        CommunityInputFlowView(viewModel: .preview())
    }
}
