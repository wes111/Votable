//
//  UsernameTextFieldStyle.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/4/23.
//

import SwiftUI
import SharedResourcesClientAndServer

struct UsernameTextFieldStyle<T: Hashable>: ViewModifier {
    @Binding var username: String
    @FocusState.Binding var focusedField: T?
    let field: T
    
    func body(content: Content) -> some View {
        content
            .keyboardType(.default)
            .textContentType(.username)
            .standardTextInputAppearance(
                text: $username,
                focusedField: $focusedField,
                focusedFieldValue: field,
                fieldType: UsernameField.self
            )
    }
}

extension View {
    func usernameTextFieldStyle<T: Hashable>(
        username: Binding<String>,
        focusedField: FocusState<T?>.Binding,
        field: T
    ) -> some View {
        self.modifier(
            UsernameTextFieldStyle(
                username: username,
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
        
        TextField("Username", text: .constant("Username"),
                  prompt: Text("Username").foregroundColor(.tertiaryBackground)
        )
        .usernameTextFieldStyle(
            username: .constant("Username"),
            focusedField: $focusedField,
            field: .username
        )
    }
}
