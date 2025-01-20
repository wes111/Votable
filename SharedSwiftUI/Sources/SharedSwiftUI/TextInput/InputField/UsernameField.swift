//
//  UsernameField.swift
//  SharedSwiftUI
//
//  Created by Wesley Luntsford on 12/31/24.
//

import Foundation
import SharedSwift

public enum UsernameField: InputField {
    public typealias Validator = UsernameInputValidator
    public static let fieldName: String = "Username"
    public static let shouldTrimWhileTapping: Bool = true
}
