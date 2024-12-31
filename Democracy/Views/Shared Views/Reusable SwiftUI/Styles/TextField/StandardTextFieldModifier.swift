//
//  TitleTextFieldStyle.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import SharedResourcesClientAndServer
import SharedSwiftUI
import SwiftUI

struct TextFieldButtonContent {
    let action: @MainActor () async -> Void
    let image: SystemImage
    var isDisabled: Bool
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
                NewAsyncButton(action: buttonContent.action) {
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

extension View {
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
#Preview {
    @FocusState var focusedField: PostFlow?
    ZStack {
        Color.primaryBackground.ignoresSafeArea()
        
        TextField("Title", text: .constant("Title"),
                  prompt: Text("Title").foregroundColor(.tertiaryBackground)
        )
        .standardTextFieldStyle(
            text: .constant("Title"),
            focusedField: $focusedField,
            focusedFieldValue: .title,
            fieldType: DefaultField.self,
            buttonContent: .init(
                action: {},
                image: .arrowRight,
                isDisabled: false
            )
        )
        .padding()
    }
}
