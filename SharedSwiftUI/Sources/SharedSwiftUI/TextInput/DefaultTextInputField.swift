//
//  DefaultTextFieldInputView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/13/24.
//

import SharedSwift
import SwiftUI

public struct DefaultTextInputField<Field: InputField>: View {
    @Environment(\.theme) var theme: Theme
    @Binding var text: String
    let axis: Axis
    
    public init(text: Binding<String>, fieldType: Field.Type, axis: Axis = .horizontal) {
        self._text = text
        self.axis = axis
    }
    
    public var body: some View {
        TextField(
            Field.fieldName,
            text: $text,
            prompt: Text(Field.fieldName).foregroundColor(theme.primaryColorScheme.tertiaryBackground),
            axis: axis
        )
    }
}

// MARK: - Preview
#Preview {
    @Previewable @Environment(\.theme) var theme: Theme
    
    ZStack {
        theme.primaryColorScheme.primaryBackground.ignoresSafeArea()
        
        DefaultTextInputField(
            text: .constant("Hello World!"),
            fieldType: DefaultField.self
        )
    }
}
