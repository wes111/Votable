//
//  TitleTextFieldStyle.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import SwiftUI

public struct TextFieldButtonContent {
    public let action: () async -> Void
    public let image: SystemImage
    public var isDisabled: Bool
    
    public init(action: @escaping () async -> Void, image: SystemImage, isDisabled: Bool) {
        self.action = action
        self.image = image
        self.isDisabled = isDisabled
    }
}

// Is this just the default text field modifier?
struct StandardTextFieldModifier<FocusedField: Hashable, Field: InputField>: ViewModifier {
    @Binding var text: String
    @FocusState.Binding var focusedField: FocusedField?
    let focusedFieldValue: FocusedField
    let fieldType: Field.Type
    let buttonContent: TextFieldButtonContent?
    
    init(
        text: Binding<String>,
        focusedField: FocusState<FocusedField?>.Binding,
        focusedFieldValue: FocusedField,
        fieldType: Field.Type,
        buttonContent: TextFieldButtonContent?
    ) {
        self._text = text
        self._focusedField = focusedField
        self.focusedFieldValue = focusedFieldValue
        self.fieldType = fieldType
        self.buttonContent = buttonContent
    }
    
    func body(content: Content) -> some View {
        HStack {
            content
            
            if let buttonContent {
                AsyncButtonWithProgress(action: buttonContent.action) {
                    Image(systemName: buttonContent.image.rawValue)
                }
                .disabled(buttonContent.isDisabled)
                .opacity(buttonContent.isDisabled ? 0.5 : 1.0)
            }
        }
        .keyboardType(.default)
        .standardTextInputAppearance(
            text: $text,
            focusedField: $focusedField,
            focusedFieldValue: focusedFieldValue,
            fieldType: fieldType
        )
    }
}

// MARK: - View Extension
public extension View {
    func standardTextFieldStyle<FocusedField: Hashable, Field: InputField>(
        text: Binding<String>,
        focusedField: FocusState<FocusedField?>.Binding,
        focusedFieldValue: FocusedField,
        fieldType: Field.Type,
        buttonContent: TextFieldButtonContent? = nil
    ) -> some View {
        self.modifier(
            StandardTextFieldModifier(
                text: text,
                focusedField: focusedField,
                focusedFieldValue: focusedFieldValue,
                fieldType: fieldType,
                buttonContent: buttonContent
            )
        )
    }
}

// MARK: - Preview
#Preview(traits: .standardPreviewModifier) {
    @Previewable @State var text: String = "Mock Title"
    @Previewable @FocusState var focusedField: MockSelectable?
        
        TextField("Title", text: $text)
        .standardTextFieldStyle(
            text: $text,
            focusedField: $focusedField,
            focusedFieldValue: .mockOne,
            fieldType: DefaultField.self,
            buttonContent: .init(
                action: {},
                image: .arrowRight,
                isDisabled: false
            )
        )
}
