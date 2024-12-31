//
//  AccountInputFlowViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/11/24.
//

import Factory
import Foundation
import SharedResourcesClientAndServer

// The InputFlowViewModel for creating new Account/User objects.
@MainActor @Observable
final class AccountInputFlowViewModel: InputFlowCoordinatorViewModel {
    var flowPath: AccountFlow = .username
    var alertModel: NewAlertModel?
    var isShowingProgress: Bool = false
    let input = AccountCreationRequestBuilder()
    private weak var coordinator: CreateAccountCoordinator?
    
    init(coordinator: CreateAccountCoordinator?) {
        self.coordinator = coordinator
    }
}


// MARK: - Methods
extension AccountInputFlowViewModel {
    
    func didCompleteFlowSuccessfully() {
        coordinator?.goToSuccess()
    }
    
    func close() {
        coordinator?.close()
    }
}
