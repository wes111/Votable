//
//  LoginViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/22/23.
//

import Factory
import Foundation
import SharedResourcesClientAndServer

enum LoginAlert: AlertModelProtocol {
    case loginError
    
    var id: String {
        return self.title
    }
    
    var title: String {
        switch self {
        case .loginError:
            "Login Error"
        }
    }
    
    var description: String {
        switch self {
        case .loginError:
            "Please try again later"
        }
    }
}

@MainActor
protocol LoginCoordinatorDelegate: AnyObject {
    func goToCreateAccount()
}

@MainActor
final class LoginViewModel: ObservableObject {
    
    @Injected(\.sessionService) private var sessionService
    @Published var password = ""
    @Published var email = ""
    @Published var alert: NewAlertModel?
    @Published var isShowingProgress = false
    
    init(coordinator: LoginCoordinatorDelegate) {
        self.coordinator = coordinator
    }
    
    private weak var coordinator: LoginCoordinatorDelegate?
}

// MARK: - Methods
extension LoginViewModel {
    
    func createAccount() {
        coordinator?.goToCreateAccount()
    }
    
    func forgotPassword() {
        print("Forgot password")
    }
    
    //@StorageActor
    func login() async {
        do {
            try await Task.sleep(nanoseconds: 2_000_000_000)
            let validatedEmail = try Email(value: email)
            let validatedPassword = try Password(value: password)
            _ = try await sessionService.login(email: validatedEmail, password: validatedPassword)
        } catch {
            print(error.localizedDescription)
            alert = LoginAlert.loginError.toNewAlertModel()
        }
    }
}
