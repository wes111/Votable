//
//  TextInputRequirements.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/9/24.
//

import SwiftUI
import SharedResourcesClientAndServer

struct FieldRequirementsView<Validator: InputValidator>: View {
    let text: String
    let currentInputErrors: [InputValidationRule]
    
    var body: some View {
        VStack(alignment: .leading, spacing: ViewConstants.extraSmallElementSpacing) {
            ForEach(Validator.validationRules, id: \.self) { rule in
                let status = status(for: rule)
                requirementLabel(text: rule.description, color: status.color, systemImage: status.systemImage.rawValue)
            }
            .foregroundColor(.tertiaryText)
        }
        .if(!Validator.validationRules.isEmpty) { view in
            view
                .padding(.top, ViewConstants.smallElementSpacing)
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
#Preview {
    ZStack {
        Color.primaryBackground.ignoresSafeArea()
        FieldRequirementsView<EmailInputValidator>(
            text: "Hello World",
            currentInputErrors: [.beginsWithAlphanumeric, .maxLength(25)]
        )
    }

}
