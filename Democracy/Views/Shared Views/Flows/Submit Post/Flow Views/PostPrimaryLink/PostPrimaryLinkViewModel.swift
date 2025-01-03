//
//  PostPrimaryLinkViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/30/24.
//

import DemocracySwiftUI
import Foundation
import SharedSwift

@MainActor @Observable
final class PostPrimaryLinkViewModel: TextInputFlowViewModel {
    let flowCoordinator: PostInputFlowViewModel
    var text: String = ""
    let focusedField = PostFlow.primaryLink
    
    init(flowCoordinator: PostInputFlowViewModel) {
        self.flowCoordinator = flowCoordinator
    }
    
    var skipAction: SkipAction {
        .canSkip(action: flowCoordinator.next)
    }
    
    var nextButtonEnabled: Bool {
        LinkInputValidator.isValid(input: text)
    }
    
    func nextButtonAction() async {
        do {
            try await flowCoordinator.input.setPrimaryLink(text)
            flowCoordinator.next()
        } catch {
            flowCoordinator.handleError(error)
        }
    }
    
    func setUserInput() {
        text = flowCoordinator.input.primaryLink?.value.absoluteString ?? ""
    }
}
