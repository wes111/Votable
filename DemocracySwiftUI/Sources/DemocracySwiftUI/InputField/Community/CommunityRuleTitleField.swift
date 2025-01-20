//
//  CommunityRuleTitleField.swift
//  DemocracySwiftUI
//
//  Created by Wesley Luntsford on 12/31/24.
//

import Foundation
import SharedSwiftUI
import SharedResourcesClientAndServer

public enum CommunityRuleTitleField: InputField {
    public typealias Validator = CommunityRuleTitleInputValidator
    public static let fieldName: String = "Rule Title"
    public static let shouldTrimWhileTapping: Bool = false
}
