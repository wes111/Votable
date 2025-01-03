//
//  CommunityTagInput+Extensions.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/27/24.
//

import SharedSwiftUI
import SharedResourcesClientAndServer

extension ValidatableInput: SelectableItem {
    public var name: String {
        value
    }
}
