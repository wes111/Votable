//
//  PostTitleViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/30/24.
//

import Foundation
import SharedResourcesClientAndServer

@MainActor @Observable
final class PostTitleViewModel: TextInputFlowViewModel {
    let flowCoordinator: PostInputFlowViewModel
    var text: String = ""
    let skipAction: SkipAction = .nonSkippable
    let focusedField = PostFlow.title
    
    init(flowCoordinator: PostInputFlowViewModel) {
        self.flowCoordinator = flowCoordinator
    }
    
    var nextButtonEnabled: Bool {
        PostTitleInputValidator.isValid(input: text)
    }
    
    func nextButtonAction() async {
        do {
            try flowCoordinator.input.setTitle(text)
            flowCoordinator.next()
        } catch {
            flowCoordinator.handleError(error)
        }
    }
    
    func setUserInput() {
        text = flowCoordinator.input.title?.value ?? ""
    }
}
