//
//  DefaultTextFieldInputView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/13/24.
//

import SwiftUI
import SharedResourcesClientAndServer

struct DefaultTextInputField<Field: InputField>: View {
    @Binding var text: String
    let axis: Axis
    
    init(text: Binding<String>, fieldType: Field.Type, axis: Axis = .horizontal) {
        self._text = text
        self.axis = axis
    }
    
    var body: some View {
        TextField(
            Field.fieldName,
            text: $text,
            prompt: Text(Field.fieldName).foregroundColor(.tertiaryBackground),
            axis: axis
        )
    }
}

// MARK: - Preview
#Preview {
    @FocusState var focusedField: CommunityFlow?
    
    ZStack {
        Color.primaryBackground.ignoresSafeArea()
        
        DefaultTextInputField(
            text: .constant("Hello World!"),
            fieldType: DefaultField.self
        )
    }
}
