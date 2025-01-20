//
//  CommunityRuleDescriptionField.swift
//  DemocracySwiftUI
//
//  Created by Wesley Luntsford on 12/31/24.
//

import Foundation
import SharedSwiftUI
import SharedResourcesClientAndServer

public enum CommunityRuleDescriptionField: InputField {
    public typealias Validator = CommunityRuleDescriptionInputValidator
    public static let fieldName: String = "Rule Description"
    public static let shouldTrimWhileTapping: Bool = false
}
