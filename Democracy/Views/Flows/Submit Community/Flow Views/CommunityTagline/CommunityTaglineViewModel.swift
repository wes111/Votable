//
//  CommunityTaglineViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/30/24.
//

import Foundation
import SharedResourcesClientAndServer

@MainActor @Observable
final class CommunityTaglineViewModel: TextInputFlowViewModel {
    let flowCoordinator: CommunityInputFlowViewModel
    var text: String = ""
    let skipAction: SkipAction = .nonSkippable
    let focusedField = CommunityFlow.tagline
    
    init(flowCoordinator: CommunityInputFlowViewModel) {
        self.flowCoordinator = flowCoordinator
    }
    
    var nextButtonEnabled: Bool {
        CommunityTaglineInputValidator.isValid(input: text)
    }
    
    func nextButtonAction() async {
        do {
            try flowCoordinator.input.setTagline(text)
            flowCoordinator.next()
        } catch {
            return flowCoordinator.handleError(.invalidInput(.tagline))
        }
    }
    
    func setUserInput() {
        text = flowCoordinator.input.tagline?.value ?? ""
    }
}
