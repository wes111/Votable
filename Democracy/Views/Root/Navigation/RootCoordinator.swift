//
//  RootCoordinator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/11/23.
//

import Factory
import Foundation
import SharedResourcesClientAndServer

@MainActor @Observable
final class RootCoordinator {
    
    @ObservationIgnored @Injected(\.userAsyncStreamManager) private var userStreamManager
    @ObservationIgnored @Injected(\.userService) private var userService
    @ObservationIgnored @Injected(\.membershipService) private var membershipService
    var loginStatus: LoginStatus = .loggedOut
    var isShowingOnboardingFlow = false
    
    let mainTabViewModel = MainTabViewModel()
    
    func createAccountCoordinator() -> CreateAccountCoordinator {
        .init(parentCoordinator: self)
    }
    
    @StorageActor
    func setupUserService() async {
        do {
            try await userService.setup()
        } catch {
            print(error)
        }
    }
    
    @StorageActor
    func setupMembershipService() async {
        do {
            try await membershipService.setup()
        } catch {
            print(error)
        }
    }
}

// MARK: - Child ViewModels
extension RootCoordinator {
    
    func loginViewModel() -> LoginViewModel {
        .init(coordinator: self)
    }
    
}

extension RootCoordinator: LoginCoordinatorDelegate {
    func goToCreateAccount() {
        isShowingOnboardingFlow = true
    }
}

extension RootCoordinator: CreateAccountCoordinatorParent {
    func dismiss() {
        isShowingOnboardingFlow = false
    }
}

// MARK: Methods
extension RootCoordinator {
    @MainActor func startSessionTask() async {
        loginStatus = await userStreamManager.currentValue == nil ? .loggedOut : .loggedIn
        
        for try await session in await userStreamManager.stream() {
            loginStatus = session == nil ? .loggedOut : .loggedIn
        }
    }
}
