//
//  CreateCommunityDestination.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/22/25.
//

import Navigator
import SharedSwiftUI
import SwiftUI

enum CreateCommunityDestination {
    case goToSuccess(communityName: String, closeAction: () -> Void)
}

extension CreateCommunityDestination: NavigationDestination {
    var view: some View {
        switch self {
        case .goToSuccess(let name, let closeAction):
            SuccessView(viewModel: CreateCommunitySuccessViewModel(
                communityName: name,
                closeAction: closeAction)
            )
        }
    }
    
    var method: NavigationMethod {
        switch self {
        case .goToSuccess:
                .push
        }
    }
}

// MARK: - Hashable
extension CreateCommunityDestination: Hashable {
    static func == (lhs: CreateCommunityDestination, rhs: CreateCommunityDestination) -> Bool {
        switch (lhs, rhs) {
        case (.goToSuccess(let lhsCommunityName, _), .goToSuccess(let rhsCommunityName, _)):
            return lhsCommunityName == rhsCommunityName
        }
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .goToSuccess(let communityName, _):
            hasher.combine("goToSuccess")
            hasher.combine(communityName)
        }
    }
}
