//
//  RootCoordinatorView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/11/23.
//

import SwiftUI
import SharedSwiftUI

struct RootCoordinatorView: View {
    @State private var viewModel: RootCoordinator
    @Environment(\.theme) var theme: Theme
    
    init(viewModel: RootCoordinator) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Group {
            if viewModel.loginStatus == .loggedOut {
                LoginView(viewModel: viewModel.loginViewModel())
            } else {
                MainTabView(viewModel: viewModel.mainTabViewModel, theme: theme)
            }
        }
        .popover(isPresented: $viewModel.isShowingOnboardingFlow) {
            CreateAccountCoordinatorView(coordinator: viewModel.createAccountCoordinator())
        }
        .task { await viewModel.startSessionTask() }
        .task { await viewModel.setupUserService() }
        .task { await viewModel.setupMembershipService() }
        
        // TODO: This should be a fullScreenCover not popover.
        // This temporarily fixes an iOS 17 memory leak.
        // https://developer.apple.com/forums/thread/736239
        
//        .fullScreenCover(isPresented: $viewModel.isShowingOnboardingFlow) {
//            OnboardingCoordinatorView(viewModel: viewModel.onboardingCoordinator())
//        }
    }
    
    @ViewBuilder
    func createViewFromPath(_ path: RootPath) -> some View {
        switch path {
            // TODO: ...
        default:
            EmptyView()
        }
    }
}

// MARK: - Preview
#Preview {
    let coordinator = RootCoordinator()
    return RootCoordinatorView(viewModel: coordinator)
}
