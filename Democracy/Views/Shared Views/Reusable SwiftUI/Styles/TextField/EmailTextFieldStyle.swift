//
//  EmailTextFieldStyle.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/3/23.
//

import SwiftUI
import SharedResourcesClientAndServer

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

extension View {
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
    @FocusState var focusedField: AccountFlow?
    
    ZStack {
        Color.primaryBackground.ignoresSafeArea()
        
        TextField("Email", text: .constant("Password"),
                  prompt: Text("Email").foregroundColor(.tertiaryBackground)
        )
        .emailTextFieldStyle(
            email: .constant("Email"),
            focusedField: $focusedField,
            field: .email
        )
    }
}
