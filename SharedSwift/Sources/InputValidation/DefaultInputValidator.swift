//
//  EmptyRequirement.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/14/24.
//

import Foundation

public enum DefaultInputValidator: InputValidator {
    public static let maxCharacterCount: Int = .max
    
    public static let validationRules: [InputValidationRule] = [
        .minLength(1),
        .maxLength(Self.maxCharacterCount),
        .onlyCommonCharacterSet
    ]
}
