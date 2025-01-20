//
//  PasswordValidation.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/4/23.
//

import Foundation

public enum PasswordInputValidator: InputValidator {
    public static let maxCharacterCount: Int = 128
    
    public static let validationRules: [InputValidationRule] = [
        .containsUppercaseLetter,
        .containsLowercaseLetter,
        .containsDigit,
        .containsSpecialCharacter,
        .minLength(8),
        .maxLength(Self.maxCharacterCount),
        .onlyCommonCharacterSet
    ]
}
