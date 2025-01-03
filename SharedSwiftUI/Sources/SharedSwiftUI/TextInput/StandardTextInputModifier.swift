//
//  StandardBorderedModifier.swift
//  Democracy
//
//  Created by Wesley Luntsford on 9/17/23.
//

import SwiftUI

public enum TextInputPadding {
    case standardTextEditor
    case standardTextField
    case smallTextInput
    
    public var value: CGFloat {
        @Environment(\.theme) var theme: Theme
        
        return switch self {
        case .standardTextEditor: theme.sizeConstants.textEditorPadding
        case .standardTextField: theme.sizeConstants.textFieldPadding
        case .smallTextInput: theme.sizeConstants.smallTextInputPadding
        }
    }
}

/// Standard shared appearance of TextFields and TextEditors.
struct StandardTextInputModifier<FocusedField: Hashable, Field: InputField>: ViewModifier {
    @Environment(\.theme) var theme: Theme
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
            .foregroundStyle(theme.primaryColorScheme.primaryText)
            .padding(fieldPadding.value)
            .background(theme.primaryColorScheme.secondaryBackground)
            .clipShape(RoundedRectangle(cornerRadius: theme.sizeConstants.cornerRadius, style: .circular))
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
public extension View {
    
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
