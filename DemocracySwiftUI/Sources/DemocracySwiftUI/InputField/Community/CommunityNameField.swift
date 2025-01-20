//
//  CommunityNameField.swift
//  DemocracySwiftUI
//
//  Created by Wesley Luntsford on 12/31/24.
//

import Foundation
import SharedSwiftUI
import SharedResourcesClientAndServer

public enum CommunityNameField: InputField {
    public typealias Validator = CommunityNameInputValidator
    public static let fieldName: String = "Community Name"
    public static let shouldTrimWhileTapping: Bool = true
}
