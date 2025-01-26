//
//  PostBodyViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/26/24.
//

import DemocracySwiftUI
import Foundation
import SharedResourcesClientAndServer

@MainActor @Observable
final class PostBodyViewModel: SubmittableTextEditorInputViewModelProtocol {
    let flowCoordinator: PostInputFlowViewModel
    var text: String = ""
    let skipAction: SkipAction = .nonSkippable
    let focusedField = PostFlow.body
    var selectedTab: PostBodyTab = .editor
    var shouldPerformOnSubmit: Bool = false
    
    init(flowViewModel: PostInputFlowViewModel) {
        self.flowCoordinator = flowViewModel
    }
    
    var markdown: String {
        ""
    }
    
    var nextButtonEnabled: Bool {
        PostBodyInputValidator.isValid(input: text)
    }
    
    func nextButtonAction() async {
        do {
            try flowCoordinator.input.setBody(text)
            flowCoordinator.next()
        } catch {
            flowCoordinator.handleError(error)
        }
    }
    
    func setUserInput() {
        text = flowCoordinator.input.body?.value ?? ""
    }
}
