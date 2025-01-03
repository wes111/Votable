//
//  CommunityResourceDescriptionField.swift
//  DemocracySwiftUI
//
//  Created by Wesley Luntsford on 12/31/24.
//

import Foundation
import SharedSwiftUI
import SharedResourcesClientAndServer

public enum CommunityResourceDescriptionField: InputField {
    public typealias Validator = CommunityResourceDescriptionInputValidator
    public static let fieldName: String = "Resource Description"
    public static let shouldTrimWhileTapping: Bool = false
}
