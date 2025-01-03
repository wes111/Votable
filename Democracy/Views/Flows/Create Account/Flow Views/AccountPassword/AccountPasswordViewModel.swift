//
//  AccountPasswordViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/30/24.
//

import DemocracySwiftUI
import Foundation
import SharedSwift

@MainActor @Observable
final class AccountPasswordViewModel: TextInputFlowViewModel {
    let flowCoordinator: AccountInputFlowViewModel
    var text: String = ""
    let skipAction: SkipAction = .nonSkippable
    let focusedField = AccountFlow.password
    
    init(flowCoordinator: AccountInputFlowViewModel) {
        self.flowCoordinator = flowCoordinator
    }
    
    var nextButtonEnabled: Bool {
        PasswordInputValidator.isValid(input: text)
    }
    
    func nextButtonAction() async {
        do {
            try flowCoordinator.input.setPassword(text)
            flowCoordinator.next()
        } catch {
            return flowCoordinator.handleError(error)
        }
    }
    
    func setUserInput() {
        text = flowCoordinator.input.password?.value ?? ""
    }
}
