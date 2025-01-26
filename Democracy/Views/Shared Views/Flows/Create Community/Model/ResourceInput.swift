//
//  ResourceInput.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/15/24.
//

import Foundation
import SharedResourcesClientAndServer

struct ResourceInput: Hashable {
    var title: CommunityResourceTitleInput
    var description: CommunityResourceDescriptionInput
    var link: Link
    var category: ResourceCategory
    
    init(title: CommunityResourceTitleInput, description: CommunityResourceDescriptionInput, link: Link, category: ResourceCategory) {
        self.title = title
        self.description = description
        self.link = link
        self.category = category
    }
}
