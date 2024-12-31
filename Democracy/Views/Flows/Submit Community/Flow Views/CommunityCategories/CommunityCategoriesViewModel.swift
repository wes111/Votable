//
//  CommunityCategoriesViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/30/24.
//

import Foundation
import SharedResourcesClientAndServer

@MainActor @Observable
final class CommunityCategoriesViewModel: TextInputFlowViewModel {
    let flowCoordinator: CommunityInputFlowViewModel
    var text: String = ""
    let skipAction: SkipAction = .nonSkippable
    let focusedField = CommunityFlow.categories
    
    init(flowCoordinator: CommunityInputFlowViewModel) {
        self.flowCoordinator = flowCoordinator
    }
    
    var nextButtonEnabled: Bool {
        !flowCoordinator.input.categories.isEmpty
    }
    
    func nextButtonAction() async {
        guard nextButtonEnabled else {
            return flowCoordinator.handleError(.itemMissing(.categories))
        }
        flowCoordinator.next()
    }
    
    func setUserInput() {
        return
    }
    
    var categories: [CommunityCategory] {
        flowCoordinator.input.categories
    }
    
    func removeCategory(_ category: CommunityCategory) {
        flowCoordinator.input.removeCategory(category)
    }
    
    // Add category
    func onSubmit() async {
        do {
            try flowCoordinator.input.addCategory(text)
            text = ""
        } catch {
            return flowCoordinator.handleError(error)
        }
    }
}
