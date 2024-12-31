//
//  AccountInputFlowView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/11/24.
//

import SwiftUI

@MainActor
struct AccountInputFlowView: View {
    @Bindable var viewModel: AccountInputFlowViewModel
    
    init(viewModel: AccountInputFlowViewModel) {
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
private extension AccountInputFlowView {
    @ViewBuilder
    var flowScreen: some View {
        InputFlowView(viewModel: viewModel) {
            switch viewModel.flowPath {
            case .username:
                AccountUsernameView(viewModel: .init(flowCoordinator: viewModel))
            case .email:
                AccountEmailView(viewModel: .init(flowCoordinator: viewModel))
            case .password:
                AccountPasswordView(viewModel: .init(flowCoordinator: viewModel))
            case .phone:
                AccountPhoneView(viewModel: .init(flowCoordinator: viewModel))
            case .acceptTerms:
                AccountAcceptTermsView(viewModel: .init(flowCoordinator: viewModel))
            }
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        AccountInputFlowView(viewModel: .preview)
    }
}
