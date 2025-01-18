//
//  TextInputRequirements.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/9/24.
//

import SwiftUI
import SharedSwift

public struct FieldRequirementsView<Validator: InputValidator>: View {
    @Environment(\.theme) var theme: Theme
    let text: String
    let currentInputErrors: [InputValidationRule]
    
    public init(text: String, currentInputErrors: [InputValidationRule]) {
        self.text = text
        self.currentInputErrors = currentInputErrors
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: theme.sizeConstants.extraSmallElementSpacing) {
            ForEach(Validator.validationRules, id: \.self) { rule in
                let status = status(for: rule)
                requirementLabel(
                    text: rule.description,
                    color: theme.primaryColorScheme.inputValidationStatusColor(status),
                    systemImage: status.systemImage.rawValue)
            }
            .foregroundColor(theme.primaryColorScheme.tertiaryText)
        }
        .if(!Validator.validationRules.isEmpty) { view in
            view
                .padding(.top, theme.sizeConstants.smallElementSpacing)
        }
    }
}

// MARK: - Subviews
extension FieldRequirementsView {
    func requirementLabel(text: String, color: Color, systemImage: String) -> some View {
        Label {
            Text(text)
        } icon: {
            Image(systemName: systemImage)
                .foregroundColor(color)
                .frame(width: 10, height: 10)
        }
        .font(.system(.caption, weight: .light))
    }
}

// MARK: - Helper Methods
private extension FieldRequirementsView {
    func status(for rule: InputValidationRule) -> InputValidationRuleStatus {
        if text.isEmpty {
            .incomplete
        } else if currentInputErrors.contains(rule) {
            .error
        } else {
            .satisfied
        }
    }
}

// MARK: - Preview
#Preview(traits: .standardPreviewModifier) {
    
    FieldRequirementsView<EmailInputValidator>(
        text: "Hello World",
        currentInputErrors: [.beginsWithAlphanumeric, .maxLength(25)]
    )
}
