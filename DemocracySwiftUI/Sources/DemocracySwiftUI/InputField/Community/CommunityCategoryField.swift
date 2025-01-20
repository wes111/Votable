//
//  CommunityCategoryField.swift
//  DemocracySwiftUI
//
//  Created by Wesley Luntsford on 12/31/24.
//

import Foundation
import SharedSwiftUI
import SharedResourcesClientAndServer

public enum CommunityCategoryField: InputField {
    public typealias Validator = CommunityCategoryInputValidator
    public static let fieldName: String = "Categories"
    public static let shouldTrimWhileTapping: Bool = false
}
