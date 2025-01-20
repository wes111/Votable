//
//  AccountAcceptTermsViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/30/24.
//

import DemocracySwiftUI
import Factory
import Foundation
import SharedResourcesClientAndServer

@MainActor @Observable
final class AccountAcceptTermsViewModel: InputFlowViewModel {
    @ObservationIgnored @Injected(\.sessionService) private var sessionService
    
    let flowCoordinator: AccountInputFlowViewModel
    let skipAction: SkipAction = .nonSkippable
    
    init(flowCoordinator: AccountInputFlowViewModel) {
        self.flowCoordinator = flowCoordinator
    }
    
    var nextButtonEnabled: Bool {
        true
    }
    
    func nextButtonAction() async {
        do {
            _ = try await sessionService.acceptTerms(accountBuilder: flowCoordinator.input)
            flowCoordinator.next()
        } catch {
            return flowCoordinator.handleError(.defaultError)
        }
    }
    
    func setUserInput() {
        return
    }
}
