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
    var selectedCategory: PostCategory?
    
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
        flowCoordinator.input.setCategory(selectedCategory)
        flowCoordinator.next()
    }
    
    func setUserInput() {
        selectedCategory = flowCoordinator.input.category
    }
    
    var postCategories: [PostCategory] {
        flowCoordinator.input.community.categories
    }
    
    func toggleCategory(_ category: PostCategory) {
        selectedCategory = (selectedCategory == category) ? nil : category
    }
}
