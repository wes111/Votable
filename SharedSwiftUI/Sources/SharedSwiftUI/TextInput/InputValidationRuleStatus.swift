//
//  InputValidationRuleStatus.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/16/24.
//

import SwiftUI

/// Represents the status of an input validation rule for user input fields.
///
/// This enum is used to determine the visual feedback (color and icon) displayed
/// below a user input text field based on the validation state of the input.
public enum InputValidationRuleStatus {
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
        @Environment(\.theme) var theme: Theme
        
        return switch self {
        case .incomplete: theme.primaryColorScheme.primaryText
        case .error: .yellow
        case .satisfied: .green
        }
    }
}
