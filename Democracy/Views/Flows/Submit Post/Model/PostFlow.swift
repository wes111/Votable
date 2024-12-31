//
//  PostFlow.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/9/24.
//

import Foundation

enum PostFlow: Int, UserInputFlow {
    static var flowTitle: String = "Post"
    
    case title = 0
    case primaryLink
    case body
    case category
    case tags
    
    var title: String {
        switch self {
        case .title: "Title"
        case .primaryLink: "Primary Link"
        case .body: "Content"
        case .category: "Category"
        case .tags: "Tags"
        }
    }
    
    var subtitle: String {
        switch self {
        case .title:
            "Create a title for your post."
        case .primaryLink:
            """
            Add a primary link to your post with previewable content. If we are unable to fetch the metadata
            for the provided link, please try a different link or skip this step.
            """
        case .body:
            """
            Add text content to your post. Optionally, use markdown to add links, \
            bold, italics, and more to your post
            """
        case .category:
            "Each post belongs to a single category within a Community."
        case .tags:
            "Add community tags to your post to improve searchability."
        }
    }
    
    var canGoBack: Bool {
        switch self {
        case .title: false
        case .primaryLink, .body, .category, .tags: true
        }
    }
}
