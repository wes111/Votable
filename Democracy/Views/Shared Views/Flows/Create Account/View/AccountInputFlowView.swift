//
//  AccountInputFlowView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/11/24.
//

import DemocracySwiftUI
import Navigator
import SwiftUI

struct AccountInputFlowView: View {
    @State private var viewModel: AccountInputFlowViewModel
    @Environment(\.navigator) var navigator: Navigator
    
    init() {
        viewModel = .init()
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
                // TODO: ...
                //navigator.navigate(to: CreateAccountDestination.goToSuccess(username: <#T##String#>, closeAction: <#T##() -> Void#>, continueAction: <#T##() -> Void#>))
            }
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
        AccountInputFlowView()
    }
}
