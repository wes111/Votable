//
//  AccountEmailViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/30/24.
//

import DemocracySwiftUI
import Foundation
import SharedSwift

@MainActor @Observable
final class AccountEmailViewModel: TextInputFlowViewModel {
    let flowCoordinator: AccountInputFlowViewModel
    var text: String = ""
    let skipAction: SkipAction = .nonSkippable
    let focusedField = AccountFlow.email
    var shouldPerformOnSubmit: Bool = false
    
    init(flowCoordinator: AccountInputFlowViewModel) {
        self.flowCoordinator = flowCoordinator
    }
    
    var nextButtonEnabled: Bool {
        EmailInputValidator.isValid(input: text)
    }
    
    func nextButtonAction() async {
        do {
            try await flowCoordinator.input.setEmail(text)
            flowCoordinator.next()
        } catch {
            return flowCoordinator.handleError(error)
        }
    }
    
    func setUserInput() {
        text = flowCoordinator.input.email?.value ?? ""
    }
}
