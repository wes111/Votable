//
//  LinkField.swift
//  SharedSwiftUI
//
//  Created by Wesley Luntsford on 12/31/24.
//

import Foundation
import SharedSwift

public enum LinkField: InputField {
    public typealias Validator = LinkInputValidator
    public static let fieldName: String = "Link"
    public static let shouldTrimWhileTapping: Bool = true
}
