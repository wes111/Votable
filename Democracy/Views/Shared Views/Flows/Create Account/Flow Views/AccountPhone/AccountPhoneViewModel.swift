//
//  AccountPhoneViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/30/24.
//

import DemocracySwiftUI
import Foundation
import SharedSwift

@MainActor @Observable
final class AccountPhoneViewModel: TextInputFlowViewModel {
    let flowCoordinator: AccountInputFlowViewModel
    var text: String = ""
    let focusedField = AccountFlow.phone
    var shouldPerformOnSubmit: Bool = false
    
    init(flowCoordinator: AccountInputFlowViewModel) {
        self.flowCoordinator = flowCoordinator
    }
    
    var skipAction: SkipAction {
        .canSkip(action: flowCoordinator.next)
    }
    
    var nextButtonEnabled: Bool {
        PhoneNumberInputValidator.isValid(input: text)
    }
    
    func nextButtonAction() async {
        do {
            try await flowCoordinator.input.setPhone(text)
            flowCoordinator.next()
        } catch {
            return flowCoordinator.handleError(error)
        }
    }
    
    func setUserInput() {
        text = flowCoordinator.input.phone?.value ?? ""
    }
}
