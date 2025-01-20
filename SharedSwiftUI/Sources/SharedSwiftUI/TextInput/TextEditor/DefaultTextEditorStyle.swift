//
//  DefaultTextEditorStyle.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/18/23.
//

import SwiftUI

@MainActor
public extension TextEditor {
    private static let minFrameHeight: CGFloat = 200.0
    
    func defaultStyle<FocusedField: Hashable, Field: InputField>(
        focusedFieldValue: FocusedField,
        text: Binding<String>,
        focusedField: FocusState<FocusedField?>.Binding,
        fieldType: Field.Type
    ) -> some View {
        @Environment(\.theme) var theme: Theme
        
        return GeometryReader { geometry in
            self
                .standardTextInputAppearance(
                    text: text,
                    focusedField: focusedField,
                    focusedFieldValue: focusedFieldValue,
                    fieldPadding: .standardTextEditor,
                    fieldType: fieldType
                )
                .scrollContentBackground(.hidden)
                .cornerRadius(theme.sizeConstants.cornerRadius)
                .frame(
                    minHeight: Self.minFrameHeight,
                    maxHeight: max(Self.minFrameHeight, geometry.size.height)
                )
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

// MARK: - Preview
#Preview(traits: .standardPreviewModifier) {
    @Previewable @State var text: String = ""
    @Previewable @FocusState var focusedField: MockSelectable?
    
    TextEditor(text: $text)
        .defaultStyle(
            focusedFieldValue: MockSelectable.mockFour,
            text: $text,
            focusedField: $focusedField,
            fieldType: DefaultField.self)
}
