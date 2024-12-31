//
//  LinkTextFieldStyle.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/2/24.
//

import SwiftUI
import SharedResourcesClientAndServer

struct LinkTextFieldModifier<FocusedField: Hashable>: ViewModifier {
    @Binding var link: String
    @FocusState.Binding var focusedField: FocusedField?
    let focusedFieldValue: FocusedField
    
    func body(content: Content) -> some View {
        content
            .keyboardType(.URL)
            .standardTextInputAppearance(
                text: $link,
                focusedField: $focusedField,
                focusedFieldValue: focusedFieldValue,
                fieldType: LinkField.self
            )
    }
}

extension View {
    func linkTextFieldStyle<FocusedField: Hashable>(
        link: Binding<String>,
        focusedField: FocusState<FocusedField?>.Binding,
        focusedFieldValue: FocusedField
    ) -> some View {
        self.modifier(
            LinkTextFieldModifier(
                link: link,
                focusedField: focusedField,
                focusedFieldValue: focusedFieldValue
            )
        )
    }
}

// MARK: - Preview
#Preview {
    @FocusState var focusedField: PostFlow?
    
    ZStack {
        Color.primaryBackground.ignoresSafeArea()
        
        TextField("Link", text: .constant("Link"),
                  prompt: Text("Link").foregroundColor(.tertiaryBackground)
        )
        .linkTextFieldStyle(
            link: .constant("Link"),
            focusedField: $focusedField,
            focusedFieldValue: .primaryLink
        )
        .padding()
    }
}
