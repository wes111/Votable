//
//  AccountInputFlowViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/11/24.
//

import DemocracySwiftUI
import Factory
import Foundation
import SharedResourcesClientAndServer
import SharedSwiftUI

// The InputFlowViewModel for creating new Account/User objects.
@MainActor @Observable
final class AccountInputFlowViewModel: InputFlowCoordinatorViewModel {
    var flowPath: AccountFlow = .username
    var alertModel: NewAlertModel?
    var isShowingProgress: Bool = false
    let input = AccountCreationRequestBuilder()
    var didCompleteSuccessfully: Bool = false
    
    init() {}
}


// MARK: - Methods
extension AccountInputFlowViewModel {
    
    func didCompleteFlowSuccessfully() {
        didCompleteSuccessfully = true
        //coordinator?.goToSuccess()
    }
}
