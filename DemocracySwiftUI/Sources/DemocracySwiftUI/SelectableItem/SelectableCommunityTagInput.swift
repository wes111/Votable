//
//  SelectableValidatableInput.swift
//  DemocracySwiftUI
//
//  Created by Wesley Luntsford on 1/2/25.
//

import Foundation
import SharedResourcesClientAndServer
import SharedSwift
import SharedSwiftUI

public struct SelectableCommunityTagInput: SelectableItem {
    public let tagInput: ValidatableInput<CommunityTagInputValidator>
    
    public init(_ tagInput: ValidatableInput<CommunityTagInputValidator>) {
        self.tagInput = tagInput
    }
    
    public var name: String {
        tagInput.value
    }
}
