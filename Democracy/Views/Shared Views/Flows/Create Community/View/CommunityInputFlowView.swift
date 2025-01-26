//
//  CommunityInputFlowView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/10/24.
//

import DemocracySwiftUI
import Navigator
import SwiftUI

struct CommunityInputFlowView: View {
    @State private var viewModel: CommunityInputFlowViewModel
    @Environment(\.navigator) var navigator: Navigator
    
    init(flowPath: CommunityFlow = .name, requestBuilder: CommunityCreationRequestBuilder = .init()) {
        viewModel = .init(flowPath: flowPath, input: requestBuilder)
    }
    
    var body: some View {
        flowScren
            .animation(.easeInOut, value: viewModel.flowPath)
            .progressModifier(isShowingProgess: $viewModel.isShowingProgress)
            .alertableModifier(alertModel: $viewModel.alertModel)
            .onChange(of: viewModel.communityName) { _, newCommunityName in
                onNewCommunityName(newCommunityName)
            }
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

// MARK: - Private Methods
private extension CommunityInputFlowView {
    
    func onNewCommunityName(_ name: String?) {
        guard let name else {
            return
        }
        navigator.navigate(to: CreateCommunityDestination.goToSuccess(
            communityName: name,
            closeAction: { navigator.dismiss() }
        ))
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        CommunityInputFlowView()
    }
}
