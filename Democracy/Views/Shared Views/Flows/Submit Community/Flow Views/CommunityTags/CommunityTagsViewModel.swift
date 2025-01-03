//
//  CommunityTagsViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/30/24.
//

import DemocracySwiftUI
import Foundation
import SharedResourcesClientAndServer
import SharedSwift

@MainActor @Observable
final class CommunityTagsViewModel: TextInputFlowViewModel {
    let flowCoordinator: CommunityInputFlowViewModel
    var text: String = ""
    let skipAction: SkipAction = .nonSkippable
    let focusedField = CommunityFlow.tags
    
    init(flowCoordinator: CommunityInputFlowViewModel) {
        self.flowCoordinator = flowCoordinator
    }
    
    var nextButtonEnabled: Bool {
        !flowCoordinator.input.tags.isEmpty
    }
    
    func nextButtonAction() async {
        guard nextButtonEnabled else {
            return flowCoordinator.handleError(.itemMissing(.tags))
        }
        flowCoordinator.next()
    }
    
    func setUserInput() {
        return
    }
    
    var tags: [SelectableCommunityTagInput] {
        flowCoordinator.input.tags.map { .init($0) }
    }
    
    func removeTag(_ tag: SelectableCommunityTagInput) {
        flowCoordinator.input.removeTag(tag.tagInput)
    }
    
    func onSubmit() async {
        do {
            try flowCoordinator.input.addTag(text)
            text = ""
        } catch {
            return flowCoordinator.handleError(error)
        }
    }
}
