//
//  CommunityDescriptionViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/26/24.
//

import DemocracySwiftUI
import Foundation
import SharedResourcesClientAndServer

@MainActor @Observable
final class CommunityDescriptionViewModel: SubmittableTextEditorInputViewModelProtocol {
    let flowCoordinator: CommunityInputFlowViewModel
    var text: String = ""
    let skipAction: SkipAction = .nonSkippable
    let focusedField = CommunityFlow.description
    var selectedTab: PostBodyTab = .editor
    var shouldPerformOnSubmit: Bool = false
    
    init(flowCoordinator: CommunityInputFlowViewModel) {
        self.flowCoordinator = flowCoordinator
    }
    
    var markdown: String {
        ""
    }
    
    var nextButtonEnabled: Bool {
        CommunityDescriptionInputValidator.isValid(input: text)
    }
    
    func nextButtonAction() async {
        do {
            try flowCoordinator.input.setDescription(text)
            flowCoordinator.next()
        } catch {
            return flowCoordinator.handleError(error)
        }
    }
    
    func setUserInput() {
        text = flowCoordinator.input.description?.value ?? ""
    }
}
