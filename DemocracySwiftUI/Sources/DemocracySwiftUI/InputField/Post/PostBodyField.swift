//
//  PostBodyField.swift
//  DemocracySwiftUI
//
//  Created by Wesley Luntsford on 12/31/24.
//

import Foundation
import SharedSwiftUI
import SharedResourcesClientAndServer

public enum PostBodyField: InputField {
    public typealias Validator = PostBodyInputValidator
    public static let fieldName: String = "Post Content"
    public static let shouldTrimWhileTapping: Bool = false
}
