//
//  PhoneTextFieldStyle.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/5/23.
//

import SwiftUI
import Combine
import SharedSwift

struct PhoneTextFieldStyle<FocusedField: Hashable>: ViewModifier {
    @Binding var phone: String
    @FocusState.Binding var focusedField: FocusedField?
    let focusedFieldValue: FocusedField
    
    func body(content: Content) -> some View {
        content
            .onReceive(Just(phone)) { input in
                phone = PhoneFormatter.format(with: "(XXX) XXX-XXXX", phone: input)
            }
            .keyboardType(.numberPad)
            .textContentType(.telephoneNumber)
            .standardTextInputAppearance(
                text: $phone,
                focusedField: $focusedField,
                focusedFieldValue: focusedFieldValue,
                fieldType: PhoneNumberField.self
            )
    }
}

// MARK: - View Extension
public extension View {
    func phoneTextFieldStyle<FocusedField: Hashable>(
        phone: Binding<String>,
        focusedField: FocusState<FocusedField?>.Binding,
        focusedFieldValue: FocusedField
    ) -> some View {
        self.modifier(
            PhoneTextFieldStyle(
                phone: phone,
                focusedField: focusedField,
                focusedFieldValue: focusedFieldValue
            )
        )
    }
}

// MARK: - Preview
#Preview(traits: .standardPreviewModifier) {
    @Previewable @State var text: String = "123-456-7890"
    @Previewable @FocusState var focusedField: MockSelectable?
    
    TextField("Phone", text: $text)
        .phoneTextFieldStyle(
            phone: $text,
            focusedField: $focusedField,
            focusedFieldValue: .mockTwo
        )
}
