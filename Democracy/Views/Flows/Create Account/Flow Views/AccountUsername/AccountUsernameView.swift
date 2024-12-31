//
//  UsernameOnboardingInputView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/4/23.
//

import SwiftUI
import SharedResourcesClientAndServer

@MainActor
struct AccountUsernameView: View {
    @State var viewModel: AccountUsernameViewModel
    @FocusState private var focusedField: AccountFlow?
    
    var body: some View {
        SubmittableTextInputView(viewModel: viewModel, focusedField: $focusedField) {
            field
        }
    }
}

// MARK: - Subviews
private extension AccountUsernameView {
    
    var field: some View {
        DefaultTextInputField(text: $viewModel.text, fieldType: UsernameField.self)
            .usernameTextFieldStyle(
                username: $viewModel.text,
                focusedField: $focusedField,
                field: .username
            )
    }
}

// MARK: - Preview
#Preview {
    AccountUsernameView(viewModel: .preview)
}
