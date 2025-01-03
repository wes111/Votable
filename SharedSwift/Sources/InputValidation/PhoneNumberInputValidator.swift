//
//  PhoneValidationError.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/13/23.
//

import Foundation

public enum PhoneNumberInputValidator: InputValidator {
    public static let maxCharacterCount: Int = 14
    
    public static let validationRules: [InputValidationRule] = [
        .maxLength(Self.maxCharacterCount),
        .minLength(14),
        .phoneNumberFormat
    ]
}

// TODO: Might need this regex?
/// Must be 10 digits long.
// "\\(\\d{3}\\) \\d{3}-\\d{4}"
