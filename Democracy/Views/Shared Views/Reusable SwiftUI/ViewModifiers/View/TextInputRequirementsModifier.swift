//
//  TextInputRequirementsModifier.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/11/24.
//

import SwiftUI
import SharedResourcesClientAndServer

// Adds requirements directly below a text input element (field or editor).
struct TextInputRequirementsModifier<Validator: InputValidator>: ViewModifier {
    @Binding var text: String
    @State private var textErrors: [InputValidationRule] = []
    
    init(text: Binding<String>, validatorType: Validator.Type) {
        self._text = text
    }
    
    func body(content: Content) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            content
            FieldRequirementsView<Validator>(text: text, currentInputErrors: textErrors)
        }
        .onChange(of: text) { _, newValue in
            textErrors = if newValue.isEmpty {
                []
            } else {
                Validator.unmetRequirements(for: newValue)
            }
        }
    }
}

// MARK: - View Extension
extension View {
    func requirements<Validator: InputValidator>(text: Binding<String>, validatorType: Validator.Type) -> some View {
        modifier(TextInputRequirementsModifier(
            text: text,
            validatorType: validatorType
        ))
    }
}

// MARK: - Preview
#Preview {
    @FocusState var focusedField: AccountFlow?
    
    ZStack {
        Color.primaryBackground.ignoresSafeArea()
        
        TextField("TextField", text: .constant("Hello World"))
            .emailTextFieldStyle(
                email: .constant("Hello World"),
                focusedField: $focusedField,
                field: .email
            )
            .requirements(
                text: .constant("Hello World!"),
                validatorType: LinkInputValidator.self
            )
    }
}
