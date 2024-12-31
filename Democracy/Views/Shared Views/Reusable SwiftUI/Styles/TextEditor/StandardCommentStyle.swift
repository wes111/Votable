//
//  StandardCommentStyle.swift
//  Democracy
//
//  Created by Wesley Luntsford on 5/28/24.
//

import SwiftUI
import SharedResourcesClientAndServer

@MainActor
extension TextEditor {
    
    func standarCommentStyle<focusedField: Hashable>(
        focusedFieldValue: focusedField,
        text: Binding<String>,
        focusedField: FocusState<focusedField?>.Binding,
        placeHolder: String
    ) -> some View {
        
        ZStack(alignment: .topLeading) {
            self
                .standardTextInputAppearance(
                    text: text,
                    focusedField: focusedField,
                    focusedFieldValue: focusedFieldValue,
                    fieldPadding: .smallTextInput,
                    fieldType: DefaultField.self // TODO: Is this correct?
                )
                .standardCommentTextEditor()
            
            if text.wrappedValue.isEmpty {
                TextEditor(text: .constant(placeHolder))
                    .font(.system(.body, weight: .regular))
                    .foregroundStyle(Color.primaryText)
                    .padding(TextInputPadding.smallTextInput.value)
                    .clipShape(RoundedRectangle(cornerRadius: ViewConstants.cornerRadius, style: .circular))
                    .disabled(true)
                    .standardCommentTextEditor()
            }
        }
    }
}

// MARK: - Helper Modifier
private struct StandardCommentTextEditorModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .scrollContentBackground(.hidden)
            .cornerRadius(ViewConstants.cornerRadius)
            .frame(minHeight: 50, maxHeight: 200)
            .fixedSize(horizontal: false, vertical: true)
    }
}

private extension View {
    func standardCommentTextEditor() -> some View {
        modifier(StandardCommentTextEditorModifier())
    }
}
