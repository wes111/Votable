//
//  StandardCommentStyle.swift
//  Democracy
//
//  Created by Wesley Luntsford on 5/28/24.
//

import SwiftUI

@MainActor
public extension TextEditor {
    
    func standarCommentStyle<focusedField: Hashable>(
        focusedFieldValue: focusedField,
        text: Binding<String>,
        focusedField: FocusState<focusedField?>.Binding,
        placeHolder: String
    ) -> some View {
        @Environment(\.theme) var theme: Theme
        
        return ZStack(alignment: .topLeading) {
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
                    .foregroundStyle(theme.primaryColorScheme.primaryText)
                    .padding(TextInputPadding.smallTextInput.value)
                    .clipShape(RoundedRectangle(cornerRadius: theme.sizeConstants.cornerRadius, style: .circular))
                    .disabled(true)
                    .standardCommentTextEditor()
            }
        }
    }
}

// MARK: - Helper Modifier
private struct StandardCommentTextEditorModifier: ViewModifier {
    @Environment(\.theme) var theme: Theme
    func body(content: Content) -> some View {
        content
            .scrollContentBackground(.hidden)
            .cornerRadius(theme.sizeConstants.cornerRadius)
            .frame(minHeight: 50, maxHeight: 200)
            .fixedSize(horizontal: false, vertical: true)
    }
}

private extension View {
    func standardCommentTextEditor() -> some View {
        modifier(StandardCommentTextEditorModifier())
    }
}
