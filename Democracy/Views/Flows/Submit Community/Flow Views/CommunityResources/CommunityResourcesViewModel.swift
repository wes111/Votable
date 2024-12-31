//
//  CommunityResourcesViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/30/24.
//

import Factory
import Foundation
import SharedResourcesClientAndServer

@MainActor @Observable
final class CommunityResourcesViewModel: InputFlowViewModel {
    @ObservationIgnored @Injected(\.communityService) private var communityService
    var flowCoordinator: CommunityInputFlowViewModel
    var title: String = ""
    var description: String = ""
    var link: String = ""
    var category: ResourceCategory = .book
    var isShowingAddResourceSheet = false
    let nextButtonEnabled = true
    var editingResource: ResourceInput? {
        didSet {
            didSetEditingResource(editingResource)
        }
    }
    
    init(flowCoordinator: CommunityInputFlowViewModel) {
        self.flowCoordinator = flowCoordinator
    }
    
    var skipAction: SkipAction {
        .canSkip(action: flowCoordinator.next)
    }
    
    func nextButtonAction() async {
        do {
            let _ = try await communityService.createCommunity(from: flowCoordinator.input)
            flowCoordinator.next()
        } catch {
            return flowCoordinator.handleError(.defaultError)
        }
    }
    
    func setUserInput() {
        return
    }
    
    var canAddResource: Bool {
        do {
            let validResource = ResourceInput(
                title: try .init(value: title),
                description: try .init(value: description),
                link: try .init(value: link),
                category: category
            )
            return !flowCoordinator.input.resources.contains(validResource)
        } catch {
            return false
        }
    }
    
    func addResource() {
        do {
            if let editingResource {
                try? updateResource(editingResource)
                self.editingResource = nil
            } else {
                try flowCoordinator.input.addResource(title: title, description: description, link: link, category: category)
                emptyInputFields()
            }
            isShowingAddResourceSheet = false
        } catch {
            return flowCoordinator.handleError(error)
        }

    }
    
    func removeResource(_ resource: ResourceInput) {
        flowCoordinator.input.removeResource(resource)
    }
    
    func updateResource(_ resource: ResourceInput) throws {
        try flowCoordinator.input.updateResource(resource, newTitle: title, newDescription: description, newLink: link, newCategory: category)
    }
    
    func beginEditingResource(_ resource: ResourceInput) {
        editingResource = resource
        isShowingAddResourceSheet = true
    }
    
    func cancelEditingResource() {
        editingResource = nil
        isShowingAddResourceSheet = false
    }
    
    var resources: [ResourceInput] {
        flowCoordinator.input.resources
    }
    
    func closeAddResourceView() {
        editingResource = nil
        isShowingAddResourceSheet = false
    }
    
    private func emptyInputFields() {
        title = ""
        description = ""
        link = ""
        category = .book
    }
    
    private func didSetEditingResource(_ resource: ResourceInput?) {
        if let resource {
            title = resource.title.value
            description = resource.description.value
            link = resource.link.value.absoluteString
            category = resource.category
        } else {
            emptyInputFields()
        }
    }
}
