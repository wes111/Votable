//
//  InputField.swift
//  SharedSwiftUI
//
//  Created by Wesley Luntsford on 12/31/24.
//

import Foundation
import SharedSwift

public protocol InputField {
    associatedtype Validator: InputValidator
    static var fieldName: String { get }
    static var maxCharacterCount: Int { get }
    static var shouldTrimWhileTapping: Bool { get }
}

public extension InputField {
    static var maxCharacterCount: Int {
        Validator.maxCharacterCount
    }
}
