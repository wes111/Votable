//
//  CommunityResourceTitleField.swift
//  DemocracySwiftUI
//
//  Created by Wesley Luntsford on 12/31/24.
//

import Foundation
import SharedSwiftUI
import SharedResourcesClientAndServer

public enum CommunityResourceTitleField: InputField {
    public typealias Validator = CommunityResourceTitleInputValidator
    public static let fieldName: String = "Resource Title"
    public static let shouldTrimWhileTapping: Bool = true
}
