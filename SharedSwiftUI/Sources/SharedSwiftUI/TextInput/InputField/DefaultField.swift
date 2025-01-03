//
//  DefaultField.swift
//  SharedSwiftUI
//
//  Created by Wesley Luntsford on 12/31/24.
//

import Foundation
import SharedSwift

public enum DefaultField: InputField {
    public typealias Validator = DefaultInputValidator
    public static let fieldName: String = "Text"
    public static let shouldTrimWhileTapping: Bool = false
}
