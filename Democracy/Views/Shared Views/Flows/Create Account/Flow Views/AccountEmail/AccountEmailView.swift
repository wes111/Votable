//
//  EmailOnboardingInputView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/4/23.
//

import DemocracySwiftUI
import SwiftUI
import SharedSwiftUI

@MainActor
struct AccountEmailView: View {
    @State var viewModel: AccountEmailViewModel
    @FocusState private var focusedField: AccountFlow?
    
    var body: some View {
        SubmittableTextInputView(viewModel: viewModel, focusedField: $focusedField) {
            field
        }
    }
}

// MARK: - Subviews
private extension AccountEmailView {
    
    var field: some View {
        DefaultTextInputField(
            text: $viewModel.text,
            fieldType: EmailField.self
        )
        .emailTextFieldStyle(
            email: $viewModel.text,
            focusedField: $focusedField,
            field: .email
        )
    }
}

// MARK: - Preview
#Preview {
    AccountEmailView(viewModel: .preview)
}
