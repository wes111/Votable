//
//  EmailValidation.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/4/23.
//

import Foundation

public enum EmailInputValidator: InputValidator {
    public static let maxCharacterCount: Int = 128
    
    public static let validationRules: [InputValidationRule] = [
        .maxLength(Self.maxCharacterCount),
        .emailFormat
    ]
}
