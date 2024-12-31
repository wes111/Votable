//
//  CommunityTagInput+Extensions.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/27/24.
//

import SharedResourcesClientAndServer

extension ValidatableInput: SelectableItem {
    var name: String {
        value
    }
}
