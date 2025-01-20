//
//  CommunityRulesViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/30/24.
//

import DemocracySwiftUI
import Foundation
import SharedResourcesClientAndServer

@MainActor @Observable
final class CommunityRulesViewModel: InputFlowViewModel {
    let flowCoordinator: CommunityInputFlowViewModel
    var title: String = ""
    var description: String = ""
    let skipAction: SkipAction = .nonSkippable
    var isShowingAddRuleSheet = false
    var editingRule: RuleInput? {
        didSet {
            didSetEditingRule(editingRule)
        }
    }
    
    init(flowCoordinator: CommunityInputFlowViewModel) {
        self.flowCoordinator = flowCoordinator
    }
    
    var nextButtonEnabled: Bool {
        !flowCoordinator.input.rules.isEmpty
    }
    
    func nextButtonAction() async {
        guard nextButtonEnabled else {
            return flowCoordinator.handleError(.itemMissing(.rules))
        }
        flowCoordinator.next()
    }
    
    func setUserInput() {
        return
    }
    
    var canAddRule: Bool {
        do {
            let validRule = RuleInput(
                title: try .init(value: title),
                description: try .init(value: description)
            )
            return !flowCoordinator.input.rules.contains(validRule)
        } catch {
            return false
        }
    }
    
    func addRule() {
        do {
            if let editingRule {
                try flowCoordinator.input.updateRule(editingRule, newTitle: title, newDescription: description)
                self.editingRule = nil
            } else {
                try flowCoordinator.input.addRule(title, description: description)
                emptyInputFields()
            }
            isShowingAddRuleSheet = false
        } catch {
            return flowCoordinator.handleError(error)
        }
    }
    
    func removeRule(_ rule: RuleInput) {
        flowCoordinator.input.removeRule(rule)
    }
    
    func beginEditingRule(_ rule: RuleInput) {
        editingRule = rule
        isShowingAddRuleSheet = true
    }
    
    func cancelEditingRule() {
        editingRule = nil
        isShowingAddRuleSheet = false
    }
    
    var rules: [RuleInput] {
        flowCoordinator.input.rules
    }
    
    private func didSetEditingRule(_ rule: RuleInput?) {
        if let rule {
            title = rule.title.value
            description = rule.description.value
        } else {
            emptyInputFields()
        }
    }
    
    private func emptyInputFields() {
        title = ""
        description = ""
    }
    
    func closeAddRuleView() {
        editingRule = nil
        isShowingAddRuleSheet = false
    }
}
