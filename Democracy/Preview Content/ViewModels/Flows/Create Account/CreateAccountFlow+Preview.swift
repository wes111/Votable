//
//  CreateAccountFlow+Preview.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/11/24.
//

import Foundation

extension AccountInputFlowViewModel {
    static let preview = AccountInputFlowViewModel()
}

extension AccountUsernameViewModel {
    static let preview = AccountUsernameViewModel(flowCoordinator: .preview)
}

extension AccountPasswordViewModel {
    static let preview = AccountPasswordViewModel(flowCoordinator: .preview)
}

extension AccountEmailViewModel {
    static let preview = AccountEmailViewModel(flowCoordinator: .preview)
}

extension AccountPhoneViewModel {
    static let preview = AccountPhoneViewModel(flowCoordinator: .preview)
}

extension AccountAcceptTermsViewModel {
    static let preview = AccountAcceptTermsViewModel(flowCoordinator: .preview)
}
