//
//  PostInputFlowView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/9/24.
//

import DemocracySwiftUI
import SwiftUI

@MainActor
struct PostInputFlowView: View {
    @Bindable var viewModel: PostInputFlowViewModel
    
    init(viewModel: PostInputFlowViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        flowScreen
            .animation(.easeInOut, value: viewModel.flowPath)
            .progressModifier(isShowingProgess: $viewModel.isShowingProgress)
            .alertableModifier(alertModel: $viewModel.alertModel)
    }
}

// MARK: - Subviews
private extension PostInputFlowView {
    @ViewBuilder
    var flowScreen: some View {
        InputFlowView(viewModel: viewModel) {
            switch viewModel.flowPath {
            case .title:
                PostTitleView(viewModel: .init(flowCoordinator: viewModel))
            case .primaryLink:
                PostPrimaryLinkView(viewModel: .init(flowCoordinator: viewModel))
            case .body:
                PostBodyView(viewModel: .init(flowViewModel: viewModel))
            case .category:
                PostCategoryView(viewModel: .init(flowCoordinator: viewModel))
            case .tags:
                PostTagsView(viewModel: .init(flowCoordinator: viewModel))
            }
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        PostInputFlowView(viewModel: .preview())
    }
}
