//
//  ValidationError.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/6/23.
//

import Foundation

// Rules for user input.
public enum InputValidationRule: Hashable, Sendable {
    case maxLength(Int)
    case minLength(Int)
    case emailFormat
    case phoneNumberFormat
    case containsUppercaseLetter
    case containsLowercaseLetter
    case containsDigit
    case containsSpecialCharacter
    case onlyAlphanumeric
    case onlyUsernameCharacterSet
    case onlyCommonCharacterSet
    case onlyTitleCharacterSet
    case beginsWithAlphanumeric
    case beginsWithHttps
    
    private static let specialCharacterSet = CharacterSet(charactersIn: "@#$%^&+=_!~*()[]{}|;:,.<>?/\\")
    private static let usernameCharacterSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789._-")
    
    private static let commonCharacterSet: CharacterSet = {
        var allowedSet = CharacterSet.alphanumerics // Letters and numbers
        allowedSet.insert(charactersIn: " ") // Allow spaces
        allowedSet.insert(charactersIn: "@#$%^&+=_!~*()[]{}|;:,.<>?/\\\"'") // Common special characters
        return allowedSet
    }()
    
    private static let titleCharacterSet: CharacterSet = {
        var allowedSet = CharacterSet.alphanumerics // Allow letters and numbers
        allowedSet.insert(charactersIn: " ") // Add spaces
        return allowedSet
    }()

    // Validation rule description.
    public var description: String {
        switch self {
        case .maxLength(let max): "Maximum length of \(max) characters."
        case .minLength(let min): "Minimum length of \(min) characters."
        case .emailFormat: "Valid email format."
        case .containsUppercaseLetter: "uppercase letter"
        case .containsLowercaseLetter: "lowercase letter"
        case .containsDigit: "digit"
        case .containsSpecialCharacter: "special character"
        case .onlyUsernameCharacterSet: "contains only alphanumeric characters, dots, underscores, and hyphens"
        case .onlyAlphanumeric: "contains only alphanumeric characters"
        case .onlyCommonCharacterSet: "contains only common characters"
        case .onlyTitleCharacterSet: "contains only title characters"
        case .beginsWithAlphanumeric: "begins with an alphanumeric character"
        case .beginsWithHttps: "begins with \"https://\""
        case .phoneNumberFormat: "Valid phone number format"
        }
    }
    
    // Validation logic for the rule.
    public func validate(input: String) -> Bool {
        switch self {
        case .maxLength(let max):
            return input.count <= max
            
        case .minLength(let min):
            return input.count >= min
            
        case .emailFormat:
            /// Local part:
            ///     Must start with a character that is either an uppercase letter (A-Z),
            ///     lowercase letter (a-z), digit (0-9), percent sign (%), plus sign (+), or hyphen (-).
            ///     Followed by zero or more occurrences of characters that are either
            ///     uppercase letters (A-Z), lowercase letters (a-z), digits (0-9), dots (.), underscores,
            ///     percent signs (%), plus signs (+), or hyphens (-).
            /// @ symbol:
            ///     The email address must contain exactly one "@" symbol.
            /// Domain name:
            ///     Must consist of one or more characters.
            ///     Allowed characters are: uppercase letters (A-Z), lowercase letters (a-z),
            ///     digits (0-9), dots (.), and hyphens (-).
            ///     Dots must not be adjacent to each other.
            /// Dot after Domain:
            ///     The email address must contain exactly one dot (.) after the "@" symbol.
            /// Top-Level Domain (TLD):
            ///     Must consist of at least two characters.
            ///     Allowed characters are: uppercase and lowercase letters (A-Z, a-z).
            let regex = "^[A-Z0-9a-z%+-][A-Z0-9a-z._%+-]*@[A-Za-z0-9]+(\\.[A-Za-z0-9]+)*\\.[A-Za-z]{2,}$"
            return NSPredicate.validate(string: input, regex: regex)
            
        case .containsUppercaseLetter:
            return input.contains { $0.isUppercase }
            
        case .containsLowercaseLetter:
            return input.contains { $0.isLowercase }
            
        case .containsDigit:
            return input.contains { $0.isNumber }
            
        case .containsSpecialCharacter:
            return input.unicodeScalars.contains { Self.specialCharacterSet.contains($0) }
            
        case .onlyUsernameCharacterSet:
            return input.unicodeScalars.allSatisfy { Self.usernameCharacterSet.contains($0) }
            
        case .onlyCommonCharacterSet:
            return input.unicodeScalars.allSatisfy { Self.commonCharacterSet.contains($0) }
            
        case .onlyTitleCharacterSet:
            return input.unicodeScalars.allSatisfy { Self.titleCharacterSet.contains($0) }
            
        case .beginsWithAlphanumeric:
            if let firstCharacter = input.first {
                return firstCharacter.isLetter || firstCharacter.isNumber
            } else {
                return false
            }
            
        case .beginsWithHttps:
            return input.hasPrefix("https://")
            
        case .phoneNumberFormat:
            return input.count == 10 && Int(input) != nil
            
        case .onlyAlphanumeric:
            return input.unicodeScalars.allSatisfy { CharacterSet.alphanumerics.contains($0) }
        }
    }
}
