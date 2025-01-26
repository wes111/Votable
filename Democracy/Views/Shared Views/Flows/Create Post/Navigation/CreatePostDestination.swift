//
//  SubmitPostPath.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import Navigator
import SharedSwiftUI
import SwiftUI

enum CreatePostDestination {
    case goToSuccess(closeAction: () -> Void)
}

extension CreatePostDestination: NavigationDestination {
    var view: some View {
        switch self {
        case .goToSuccess(let closeAction):
            SuccessView(viewModel: PostSuccessViewModel(closeAction: closeAction))
        }
    }
}

// MARK: - Hashable
extension CreatePostDestination: Hashable {
    static func == (lhs: CreatePostDestination, rhs: CreatePostDestination) -> Bool {
        // All instances of `.goToSuccess` are considered equal, as we cannot compare closures.
        switch (lhs, rhs) {
        case (.goToSuccess, .goToSuccess):
            return true
        }
    }
    
    func hash(into hasher: inout Hasher) {
        // Use a unique identifier for the case to generate a hash.
        switch self {
        case .goToSuccess:
            hasher.combine("goToSuccess")
        }
    }
}
