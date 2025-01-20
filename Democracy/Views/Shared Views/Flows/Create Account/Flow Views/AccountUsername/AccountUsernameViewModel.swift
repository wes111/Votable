//
//  AccountUsernameViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/30/24.
//

import DemocracySwiftUI
import Factory
import Foundation
import SharedSwift

@MainActor @Observable
final class AccountUsernameViewModel: TextInputFlowViewModel {
    @ObservationIgnored @Injected(\.userService) var userService
    
    let flowCoordinator: AccountInputFlowViewModel
    var text: String = ""
    let skipAction: SkipAction = .nonSkippable
    let focusedField = AccountFlow.username
    var shouldPerformOnSubmit: Bool = false
    
    init(flowCoordinator: AccountInputFlowViewModel) {
        self.flowCoordinator = flowCoordinator
    }
    
    var nextButtonEnabled: Bool {
        UsernameInputValidator.isValid(input: text)
    }
    
    func nextButtonAction() async {
        do {
            try await flowCoordinator.input.setUsername(text)
            flowCoordinator.next()
        } catch {
            return flowCoordinator.handleError(error)
        }
    }
    
    func setUserInput() {
        text = flowCoordinator.input.username?.value ?? ""
    }
}
