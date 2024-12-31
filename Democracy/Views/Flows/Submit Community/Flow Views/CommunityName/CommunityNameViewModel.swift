//
//  CommunityNameViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/30/24.
//

import Foundation
import SharedResourcesClientAndServer

@MainActor @Observable
final class CommunityNameViewModel: TextInputFlowViewModel {
    let flowCoordinator: CommunityInputFlowViewModel
    var text: String = ""
    let skipAction: SkipAction = .nonSkippable
    let focusedField = CommunityFlow.name

    init(flowCoordinator: CommunityInputFlowViewModel) {
        self.flowCoordinator = flowCoordinator
    }
    
    var nextButtonEnabled: Bool {
        CommunityNameInputValidator.isValid(input: text)
    }
    
    func nextButtonAction() async {
        do {
            try await flowCoordinator.input.setName(text)
            flowCoordinator.next()
        } catch {
            return flowCoordinator.handleError(error)
        }
    }
    
    func setUserInput() {
        text = flowCoordinator.input.name?.value ?? ""
    }
}
