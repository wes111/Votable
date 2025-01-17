//
//  InputFlowView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/9/24.
//

import SharedSwiftUI
import SwiftUI

// Generic. Shows an entire InputFlow, e.g. CreateCommunity, CreatePost, etc.
@MainActor
public struct InputFlowView<ViewModel:  InputFlowCoordinatorViewModel, FlowContent: View>: View {
    @Environment(\.theme) var theme: Theme
    @Bindable var viewModel: ViewModel
    @ViewBuilder let content: FlowContent
    
    public init(viewModel: ViewModel, @ViewBuilder content: () -> FlowContent) {
        self.viewModel = viewModel
        self.content = content()
    }
    
    public var body: some View {
        primaryContent
            .toolbarNavigation(
                leadingContent: viewModel.leadingButtons,
                trailingContent: viewModel.trailingButtons,
                theme: theme
            )
            //.task { viewModel.setUserInput() }
    }
}

// MARK: - Private Subviews
private extension InputFlowView {
    
    var primaryContent: some View {
        ZStack(alignment: .center) {
            theme.primaryColorScheme.primaryBackground.ignoresSafeArea()
            
            // The GeometryReader here prevents the view from moving
            // with keyboard appearance/disappearance.
            GeometryReader { _ in
                VStack(alignment: .leading, spacing: theme.sizeConstants.elementSpacing) {
                    HorizontalProgressView(
                        totalProgress: viewModel.totalProgress,
                        currentProgress: viewModel.currentProgress
                    )
                    
                    Text(viewModel.viewTitle)
                        .standardScreenTitle()
                    
                    content
                        .titledElement(title: viewModel.viewSubtitle, theme: theme)
                }
                .padding(theme.sizeConstants.screenPadding)
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        InputFlowView(viewModel: MockInputFlowCoordinator()) {
            Text("Hello World")
            //PostTitleView(viewModel: .preview)
        }
    }
}
