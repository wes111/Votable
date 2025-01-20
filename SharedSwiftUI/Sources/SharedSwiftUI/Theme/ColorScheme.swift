//
//  ColorScheme.swift
//  SharedSwiftUI
//
//  Created by Wesley Luntsford on 12/29/24.
//

import SwiftUI

public struct ColorScheme: Sendable {
    public let primaryBackground: Color
    public let secondaryBackground: Color
    public let tertiaryBackground: Color
    public let quaternaryBackground: Color
    
    public let primaryText: Color
    public let secondaryText: Color
    public let tertiaryText: Color
    
    public let primaryAccent: Color
    public let secondaryAccent: Color
    
    func inputValidationStatusColor(_ inputStatus: InputValidationRuleStatus) -> Color {
        switch inputStatus {
        case .incomplete: primaryText
        case .error: .yellow
        case .satisfied: .green
        }
    }
    
    public init(
        primaryBackground: Color,
        secondaryBackground: Color,
        tertiaryBackground: Color,
        quaternaryBackground: Color,
        primaryText: Color,
        secondaryText: Color,
        tertiaryText: Color,
        primaryAccent: Color,
        secondaryAccent: Color
    ) {
        self.primaryBackground = primaryBackground
        self.secondaryBackground = secondaryBackground
        self.tertiaryBackground = tertiaryBackground
        self.quaternaryBackground = quaternaryBackground
        self.primaryText = primaryText
        self.secondaryText = secondaryText
        self.tertiaryText = tertiaryText
        self.primaryAccent = primaryAccent
        self.secondaryAccent = secondaryAccent
    }
}
