//
//  CreateCommunityInput.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import Factory
import Foundation
import SharedResourcesClientAndServer

// Models the user's input through the Create Community flow.
// Initially there is no user input, hence the optional and empty collection types.
// Should only throw errors of type `CreationRequestBuilderError`
@MainActor @Observable
final class CommunityCreationRequestBuilder: CreationRequestBuilder {
    typealias Flow = CommunityFlow
    @ObservationIgnored @Injected(\.communityService) private var communityService
    private(set) var name: CommunityName?
    private(set) var description: CommunityDescription?
    private(set) var categories: [CommunityCategory] = []
    private(set) var tags: [CommunityTagInput] = []
    private(set) var tagline: CommunityTagline?
    private(set) var rules: [RuleInput] = []
    private(set) var settings: CommunitySettings = CommunitySettings()
    private(set) var resources: [ResourceInput] = []
    
    init() {}
    
    func setName(_ name: String) async throws(BuilderError) {
        self.name = try await validateAndCheckAvailability(
            value: name,
            transform: { try CommunityName(value: $0) },
            availabilityCheck: { try await communityService.isCommunityNameAvailable($0) },
            field: .name
        )
    }
    
    func setDescription(_ description: String) throws(BuilderError) {
        self.description = try validate(
            value: description,
            transform: { try CommunityDescription(value: $0) },
            field: .description
        )
    }
    
    func addCategory(_ category: String) throws(BuilderError) {
        try addItem(
            value: category,
            existingItems: &categories,
            transform: { try CommunityCategory(value: $0) },
            field: .categories
        )
    }
    
    func removeCategory(_ category: CommunityCategory) {
        categories.removeAll(where: { $0 == category })
    }
    
    func addTag(_ tag: String) throws(BuilderError)  {
        try addItem(
            value: tag,
            existingItems: &tags,
            transform: { try CommunityTagInput(value: $0) },
            field: .tags
        )
    }
    
    func removeTag(_ tag: CommunityTagInput) {
        tags.removeAll(where: { $0 == tag })
    }
    
    func setTagline(_ tagline: String) throws(BuilderError)  {
        self.tagline = try validate(
            value: tagline,
            transform: { try CommunityTagline(value: $0) },
            field: .tagline
        )
    }
    
    private func validatedRuleInput(title: String, description: String) throws(BuilderError) -> RuleInput {
        do {
            return RuleInput(
                title: try CommunityRuleTitleInput(value: title),
                description: try CommunityRuleDescriptionInput(value: description)
            )
        } catch {
            throw .invalidInput(.rules)
        }
    }
    
    private func validatedResourceInput(
        title: String,
        description: String,
        link: String,
        category: ResourceCategory
    ) throws(BuilderError) -> ResourceInput {
        do {
            return ResourceInput(
                title: try CommunityResourceTitleInput(value: title),
                description: try CommunityResourceDescriptionInput(value: description),
                link: try Link(value: link),
                category: category
            )
        } catch {
            throw .invalidInput(.resources)
        }
    }
    
    func addRule(_ title: String, description: String) throws(BuilderError) {
        let rule = try validatedRuleInput(title: title, description: description)
        try checkDuplicate(input: rule, existingItems: rules, field: .rules)
        rules.append(rule)
    }
    
    func addResource(title: String, description: String, link: String, category: ResourceCategory) throws(BuilderError) {
        let resource = try validatedResourceInput(title: title, description: description, link: link, category: category)
        try checkDuplicate(input: resource, existingItems: resources, field: .resources)
        resources.append(resource)
    }
    
    func updateRule(_ rule: RuleInput, newTitle: String, newDescription: String) throws(BuilderError) {
        let updatedRule = try validatedRuleInput(title: newTitle, description: newDescription)
        try updateItem(item: rule, existingItems: &rules, updatedItem: updatedRule, field: .rules)
    }
    
    func updateResource(
        _ resource: ResourceInput,
        newTitle: String,
        newDescription: String,
        newLink: String,
        newCategory: ResourceCategory
    ) throws(BuilderError) {
        let updatedResource = try validatedResourceInput(
            title: newTitle, description: newDescription, link: newLink, category: newCategory
        )
        try updateItem(item: resource, existingItems: &resources, updatedItem: updatedResource, field: .resources)
    }
    
    func removeRule(_ rule: RuleInput) {
        rules.removeAll(where: { $0 == rule })
    }
    
    func removeResource(_ resource: ResourceInput) {
        resources.removeAll(where: { $0 == resource })
    }
    
    func setSettings(_ settings: CommunitySettings) {
        self.settings = settings
    }
    
    func build(userId: String) throws(BuilderError) -> CommunityCreationRequest {
        guard let name, let description, let tagline, !categories.isEmpty, !tags.isEmpty, !rules.isEmpty else {
            throw .defaultError
        }
        
        return CommunityCreationRequest(
            creatorId: userId,
            name: name.value,
            descriptionText: description.value,
            rules: rules.map { RuleCreationRequest(communityId: name.value, title: $0.title.value, description: $0.description.value) },
            resources: resources.map { ResourceCreationRequest(title: $0.title.value, description: $0.description.value, link: $0.link.value, category: $0.category, communityId: name.value) },
            postCategories: categories.map{ PostCategoryCreationRequest(name: $0.value, imageUrl: nil, communityId: name.value) },
            tags: tags.map { CommunityTagCreationRequest(communityId: name.value, name: $0.value) },
            tagline: tagline.value,
            settings: settings.toCreationRequest()
        )
    }
}
