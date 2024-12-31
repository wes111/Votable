//
//  DescriptionField.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/26/24.
//

import SwiftUI
import SharedResourcesClientAndServer

struct DescriptionField<FocusedField: Hashable>: View {
    @Binding var description: String
    @FocusState.Binding var focusedField: FocusedField?
    let focusedFieldValue: FocusedField
    
    var body: some View {
        TextField(
            "Description",
            text: $description,
            prompt: Text("Description").foregroundColor(.tertiaryBackground),
            axis: .vertical
        )
        .lineLimit(3...4)
        .requirements(
            text: $description,
            validatorType: DefaultInputValidator.self
        )
        .standardTextFieldStyle(
            text: $description,
            focusedField: $focusedField,
            focusedFieldValue: focusedFieldValue,
            fieldType: CommunityRuleDescriptionField.self // TODO: Needs to be more generic...
        )
        .titledElement(title: "Description")
    }
}

// MARK: - Preview
#Preview {
    @FocusState var focusedField: AddResourceField?
    
    DescriptionField(
        description: .constant("Description"),
        focusedField: $focusedField,
        focusedFieldValue: AddResourceField.description
    )
}
