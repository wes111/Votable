//
//  CommunityTagField.swift
//  DemocracySwiftUI
//
//  Created by Wesley Luntsford on 12/31/24.
//

import Foundation
import SharedSwiftUI
import SharedResourcesClientAndServer

public enum CommunityTagField: InputField {
    public typealias Validator = CommunityTagInputValidator
    public static let fieldName: String = "Tags"
    public static let shouldTrimWhileTapping: Bool = true
}
