//
//  EmailTextFieldStyle.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/3/23.
//

import SwiftUI

struct EmailTextFieldStyle<Field: Hashable>: ViewModifier {
    @Binding var email: String
    @FocusState.Binding var focusedField: Field?
    let field: Field
    
    func body(content: Content) -> some View {
        content
            .keyboardType(.emailAddress)
            .textContentType(.emailAddress)
            .standardTextInputAppearance(
                text: $email,
                focusedField: $focusedField,
                focusedFieldValue: field,
                fieldType: EmailField.self
            )
    }
}

// MARK: - View Extension
public extension View {
    func emailTextFieldStyle<Field: Hashable>(
        email: Binding<String>,
        focusedField: FocusState<Field?>.Binding,
        field: Field
    ) -> some View {
        self.modifier(
            EmailTextFieldStyle(
                email: email,
                focusedField: focusedField,
                field: field
            )
        )
    }
}

// MARK: - Preview
#Preview {
    @Previewable @FocusState var focusedField: MockSelectable?
    @Previewable @Environment(\.theme) var theme: Theme
    
    ZStack {
        theme.primaryColorScheme.primaryBackground.ignoresSafeArea()
        
        TextField(
            "Email",
            text: .constant("Password"),
            prompt: Text("Email").foregroundColor(theme.primaryColorScheme.tertiaryBackground)
        )
        .emailTextFieldStyle(
            email: .constant("Email"),
            focusedField: $focusedField,
            field: .mockOne
        )
    }
}
