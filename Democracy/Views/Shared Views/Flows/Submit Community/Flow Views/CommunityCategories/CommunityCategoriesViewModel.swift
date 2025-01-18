//
//  CommunityCategoriesViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/30/24.
//

import DemocracySwiftUI
import Foundation
import SharedResourcesClientAndServer

@MainActor @Observable
final class CommunityCategoriesViewModel: TextInputFlowViewModel {
    let flowCoordinator: CommunityInputFlowViewModel
    var text: String = ""
    let skipAction: SkipAction = .nonSkippable
    let focusedField = CommunityFlow.categories
    var shouldPerformOnSubmit: Bool = false
    
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
    
    var categories: [SelectableCommunityCategoryInput] {
        flowCoordinator.input.categories.map { .init($0) }
    }
    
    func removeCategory(_ category: SelectableCommunityCategoryInput) {
        flowCoordinator.input.removeCategory(category.categoryInput)
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
