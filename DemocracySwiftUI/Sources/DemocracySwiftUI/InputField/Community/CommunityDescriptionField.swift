//
//  CommunityDescriptionField.swift
//  DemocracySwiftUI
//
//  Created by Wesley Luntsford on 12/31/24.
//

import Foundation
import SharedSwiftUI
import SharedResourcesClientAndServer

public enum CommunityDescriptionField: InputField {
    public typealias Validator = CommunityDescriptionInputValidator
    public static let fieldName: String = "Community Description"
    public static let shouldTrimWhileTapping: Bool = false
}
