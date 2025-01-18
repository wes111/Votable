//
//  UsernameTextFieldStyle.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/4/23.
//

import SwiftUI

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

// MARK: - View Extension
public extension View {
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
#Preview(traits: .standardPreviewModifier) {
    @Previewable @State var text: String = "User123"
    @Previewable @FocusState var focusedField: MockSelectable?
    
    TextField("Username", text: $text)
        .usernameTextFieldStyle(
            username: $text,
            focusedField: $focusedField,
            field: .mockOne
        )
}
