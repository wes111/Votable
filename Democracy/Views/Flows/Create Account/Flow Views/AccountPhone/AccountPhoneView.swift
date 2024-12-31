//
//  PhoneOnboardingInputView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/4/23.
//

import SwiftUI
import SharedResourcesClientAndServer

@MainActor
struct AccountPhoneView: View {
    @State var viewModel: AccountPhoneViewModel
    @FocusState private var focusedField: AccountFlow?
    
    var body: some View {
        SubmittableTextInputView(viewModel: viewModel, focusedField: $focusedField) {
            field
        }
    }
}

// MARK: - Subviews
private extension AccountPhoneView {
    
    var field: some View {
        DefaultTextInputField(text: $viewModel.text, fieldType: PhoneNumberField.self)
            .phoneTextFieldStyle(
                phone: $viewModel.text,
                focusedField: $focusedField,
                focusedFieldValue: .phone
            )
    }
}

// MARK: - Preview
#Preview {
    AccountPhoneView(viewModel: .preview)
}
