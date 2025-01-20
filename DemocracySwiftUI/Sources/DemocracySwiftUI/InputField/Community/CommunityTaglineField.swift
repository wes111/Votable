//
//  CommunityTaglineField.swift
//  DemocracySwiftUI
//
//  Created by Wesley Luntsford on 12/31/24.
//

import Foundation
import SharedSwiftUI
import SharedResourcesClientAndServer

public enum CommunityTaglineField: InputField {
    public typealias Validator = CommunityTaglineInputValidator
    public static let fieldName: String = "Community Tagline"
    public static let shouldTrimWhileTapping: Bool = false
}
