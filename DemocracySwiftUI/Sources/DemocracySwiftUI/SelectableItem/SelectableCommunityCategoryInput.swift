//
//  SelectableCommunityCategoryInput.swift
//  DemocracySwiftUI
//
//  Created by Wesley Luntsford on 1/2/25.
//

import Foundation
import SharedResourcesClientAndServer
import SharedSwift
import SharedSwiftUI

public struct SelectableCommunityCategoryInput: SelectableItem {
    public let categoryInput: ValidatableInput<CommunityCategoryInputValidator>
    
    public init(_ categoryInput: ValidatableInput<CommunityCategoryInputValidator>) {
        self.categoryInput = categoryInput
    }
    
    public var name: String {
        categoryInput.value
    }
}
