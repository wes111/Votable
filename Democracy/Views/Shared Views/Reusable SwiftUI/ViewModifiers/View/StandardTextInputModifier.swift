//
//  StandardBorderedModifier.swift
//  Democracy
//
//  Created by Wesley Luntsford on 9/17/23.
//

import Foundation
import SwiftUI
import SharedResourcesClientAndServer

enum TextInputPadding {
    case standardTextEditor
    case standardTextField
    case smallTextInput
    
    var value: CGFloat {
        switch self {
        case .standardTextEditor:
            ViewConstants.textEditorPadding
        case .standardTextField:
            ViewConstants.textFieldPadding
        case .smallTextInput:
            ViewConstants.smallTextInputPadding
        }
    }
}

/// Standard shared appearance of TextFields and TextEditors.
struct StandardTextInputModifier<FocusedField: Hashable, Field: InputField>: ViewModifier {
    @Binding var text: String
    @FocusState.Binding var focusedField: FocusedField?
    let focusedFieldValue: FocusedField
    let fieldPadding: TextInputPadding
    let fieldType: Field.Type
    
    init(
        text: Binding<String>,
        focusedField: FocusState<FocusedField?>.Binding,
        focusedFieldValue: FocusedField,
        fieldPadding: TextInputPadding,
        fieldType: Field.Type
    ) {
        self._text = text
        self._focusedField = focusedField
        self.focusedFieldValue = focusedFieldValue
        self.fieldPadding = fieldPadding
        self.fieldType = fieldType
    }
    
    func body(content: Content) -> some View {
        content
            .if(Field.shouldTrimWhileTapping) { view in
                view.trimWhiteSpace(text: $text)
            }
            .font(.system(.body, weight: .regular))
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .foregroundStyle(Color.primaryText)
            .padding(fieldPadding.value)
            .background(Color.onBackground)
            .clipShape(RoundedRectangle(cornerRadius: ViewConstants.cornerRadius, style: .circular))
            .requirements(text: $text, validatorType: Field.Validator.self)
            .limitCharacters(text: $text, count: Field.maxCharacterCount)
            .focused($focusedField, equals: focusedFieldValue)
            .submitLabel(.next)
            .onTapGesture {
                focusedField = focusedFieldValue
            }
    }
}

// MARK: - View Extension
extension View {
    
    func standardTextInputAppearance<T: Hashable, Field: InputField>(
        text: Binding<String>,
        focusedField: FocusState<T?>.Binding,
        focusedFieldValue: T,
        fieldPadding: TextInputPadding = .standardTextField,
        fieldType: Field.Type
    ) -> some View {
        modifier(StandardTextInputModifier<T, Field>(
            text: text,
            focusedField: focusedField,
            focusedFieldValue: focusedFieldValue,
            fieldPadding: fieldPadding,
            fieldType: fieldType
        ))
    }
}
