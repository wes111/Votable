//
//  EmailField.swift
//  SharedSwiftUI
//
//  Created by Wesley Luntsford on 12/31/24.
//

import Foundation
import SharedSwift

public enum EmailField: InputField {
    public typealias Validator = EmailInputValidator
    public static let fieldName: String = "Email"
    public static let shouldTrimWhileTapping: Bool = true
}
