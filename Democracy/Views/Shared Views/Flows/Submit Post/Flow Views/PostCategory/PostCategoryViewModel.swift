//
//  PostCategoryViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/30/24.
//

import DemocracySwiftUI
import Foundation
import SharedResourcesClientAndServer

@MainActor @Observable
final class PostCategoryViewModel: InputFlowViewModel {
    let flowCoordinator: PostInputFlowViewModel
    let skipAction: SkipAction = .nonSkippable
    var selectedCategory: SelectablePostCategory?
    
    init(flowCoordinator: PostInputFlowViewModel) {
        self.flowCoordinator = flowCoordinator
    }
    
    var nextButtonEnabled: Bool {
        selectedCategory != nil
    }
    
    func nextButtonAction() async {
        guard let selectedCategory else {
            return flowCoordinator.handleError(.itemMissing(.category))
        }
        flowCoordinator.input.setCategory(selectedCategory.postCategory)
        flowCoordinator.next()
    }
    
    func setUserInput() {
        selectedCategory = if let category = flowCoordinator.input.category {
            SelectablePostCategory(category)
        } else {
            nil
        }
    }
    
    var postCategories: [SelectablePostCategory] {
        flowCoordinator.input.community.categories.map{ SelectablePostCategory($0) }
    }
    
    func toggleCategory(_ category: SelectablePostCategory) {
        selectedCategory = (selectedCategory == category) ? nil : category
    }
}
