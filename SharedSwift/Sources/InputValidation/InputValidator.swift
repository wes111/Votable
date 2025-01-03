//
//  InputValidator.swift
//  SharedResourcesClientAndServer
//
//  Created by Wesley Luntsford on 11/15/24.
//

import Foundation

public protocol InputValidator: Equatable, Hashable {
    static var validationRules: [InputValidationRule] { get }
    static func unmetRequirements(for input: String) -> [InputValidationRule]
    static func isValid(input: String) -> Bool
    static var maxCharacterCount: Int { get }
}

public extension InputValidator {
    static func unmetRequirements(for input: String) -> [InputValidationRule] {
        validationRules.filter { !$0.validate(input: input) }
    }

    static func isValid(input: String) -> Bool {
        unmetRequirements(for: input).isEmpty
    }
}
