//
//  OnboardingPath.swift
//  Democracy
//
//  Created by Wesley Luntsford on 9/30/23.
//

import Navigator
import SharedSwiftUI
import SwiftUI

enum CreateAccountDestination {
    case goToSuccess(username: String, closeAction: () -> Void, continueAction: () -> Void)
}

extension CreateAccountDestination: NavigationDestination {
    var view: some View {
        switch self {
        case .goToSuccess(let username, let closeAction, let continueAction):
            SuccessView(viewModel: CreateAccountSuccessViewModel(
                closeAction: closeAction,
                continueAction: continueAction,
                username: username
            ))
        }
    }
}

// MARK: - Hashable
extension CreateAccountDestination: Hashable {
    static func == (lhs: CreateAccountDestination, rhs: CreateAccountDestination) -> Bool {
        switch (lhs, rhs) {
        case (.goToSuccess(let lhsUsername, _, _), .goToSuccess(let rhsUsername, _, _)):
            // Compare only the username; ignore closures as they are not equatable.
            return lhsUsername == rhsUsername
        }
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .goToSuccess(let username, _, _):
            // Hash a unique identifier for the case and the username.
            hasher.combine("goToSuccess")
            hasher.combine(username)
        }
    }
}
