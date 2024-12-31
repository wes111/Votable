//
//  RuleInput.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/15/24.
//

import Foundation
import SharedResourcesClientAndServer

struct RuleInput: Hashable {
    var title: CommunityRuleTitleInput
    var description: CommunityRuleDescriptionInput
    
    init(title: CommunityRuleTitleInput, description: CommunityRuleDescriptionInput) {
        self.title = title
        self.description = description
    }
}
