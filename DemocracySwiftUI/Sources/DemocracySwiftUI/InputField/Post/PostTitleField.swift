//
//  PostTitleField.swift
//  DemocracySwiftUI
//
//  Created by Wesley Luntsford on 12/31/24.
//

import Foundation
import SharedSwiftUI
import SharedResourcesClientAndServer

public enum PostTitleField: InputField {
    public typealias Validator = PostTitleInputValidator
    public static let fieldName: String = "Post Title"
    public static let shouldTrimWhileTapping: Bool = false
}
