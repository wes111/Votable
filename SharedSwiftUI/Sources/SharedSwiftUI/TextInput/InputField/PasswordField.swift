//
//  PasswordField.swift
//  SharedSwiftUI
//
//  Created by Wesley Luntsford on 12/31/24.
//

import Foundation
import SharedSwift

public enum PasswordField: InputField {
    public typealias Validator = PasswordInputValidator
    public static let fieldName: String = "Password"
    public static let shouldTrimWhileTapping: Bool = true
}
