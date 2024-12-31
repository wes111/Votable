//
//  InputValidationRuleStatus.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/16/24.
//

import SharedSwiftUI
import SwiftUI

/// Represents the status of an input validation rule for user input fields.
///
/// This enum is used to determine the visual feedback (color and icon) displayed
/// below a user input text field based on the validation state of the input.
enum InputValidationRuleStatus {
    case incomplete
    case error
    case satisfied
    
    var systemImage: SystemImage {
        switch self {
        case .incomplete: .asterisk
        case .error: .exclamationmarkTriangle
        case .satisfied: .checkmarkCircleFill
        }
    }
    
    var color: Color {
        switch self {
        case .incomplete: .primaryText
        case .error: .yellow
        case .satisfied: .green
        }
    }
}
