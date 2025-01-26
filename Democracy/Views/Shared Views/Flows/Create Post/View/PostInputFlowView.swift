//
//  PostInputFlowView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/9/24.
//

import DemocracySwiftUI
import Navigator
import SharedResourcesClientAndServer
import SwiftUI

struct PostInputFlowView: View {
    @State private var viewModel: PostInputFlowViewModel
    @Environment(\.navigator) var navigator: Navigator
    
    init(community: Community, postFlow: PostFlow = .title) {
        viewModel = .init(community: community, flowPath: postFlow)
    }
    
    var body: some View {
        flowScreen
            .animation(.easeInOut, value: viewModel.flowPath)
            .progressModifier(isShowingProgess: $viewModel.isShowingProgress)
            .alertableModifier(alertModel: $viewModel.alertModel)
            .onChange(of: viewModel.didCompleteSuccessfully) { _, didCompleteSuccessfully in
                guard didCompleteSuccessfully else {
                    return
                }
                navigator.navigate(to: CreatePostDestination.goToSuccess(closeAction: { navigator.dismiss() }))
            }
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
        PostInputFlowView(community: .preview)
    }
}
