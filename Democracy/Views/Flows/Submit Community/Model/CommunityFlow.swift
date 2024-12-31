//
//  CommunityFlow.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/10/24.
//

import Foundation
import SharedResourcesClientAndServer

enum CommunityFlow: Int, UserInputFlow {
    case name = 0
    case tagline
    case description
    case categories
    case tags
    case rules
    case settings
    case resources
    
    static var flowTitle: String = "Community"
    
    var title: String {
        switch self {
        case .name: "Community Name"
        case .tagline: "Community Tagline"
        case .description: "Community Description"
        case .categories: "Community Categories"
        case .tags: "Community Tags"
        case .rules: "Community Rules"
        case .settings: "Community Settings"
        case .resources: "Community Resources"
        }
    }
    
    var subtitle: String {
        switch self {
        case .name:
            "Create a name for the new community."
        case .tagline:
            "Add a tagline for users to get a quick overview of the community's main topic."
        case .description:
            "Add a description to the new community."
        case .categories:
            "Add at least one category to the community. Categories are used to organize posts. More categories can be added later."
        case .tags:
            "Add tags to improve searchability of posts within the community."
        case .rules:
            "Add rules to the community that must be followed by all users."
        case .settings:
            "Choose the initial community settings. These can be updated later."
        case .resources:
            "Add Community Resources, including websites, books, and movies"
        }
    }
    
    var canGoBack: Bool {
        switch self {
        case .name: false
        case .tagline, .description, .categories, .tags, .rules, .settings, .resources: true
        }
    }
}
