//
//  PhoneNumberField.swift
//  SharedSwiftUI
//
//  Created by Wesley Luntsford on 12/31/24.
//

import Foundation
import SharedSwift

public enum PhoneNumberField: InputField {
    public typealias Validator = PhoneNumberInputValidator
    public static let fieldName: String = "Phone Number"
    public static let shouldTrimWhileTapping: Bool = true
}
