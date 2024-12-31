//
//  PasswordOnboardingInputView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/4/23.
//

import SwiftUI
import SharedResourcesClientAndServer

@MainActor
struct AccountPasswordView: View {
    @State var viewModel: AccountPasswordViewModel
    @FocusState private var focusedField: AccountFlow?
    
    var body: some View {
        SubmittableTextInputView(viewModel: viewModel, focusedField: $focusedField) {
            field
        }
    }
}

// MARK: - Subviews and Computed Properties
extension AccountPasswordView {
    
    var field: some View {
        CustomSecureField(
            secureText: $viewModel.text,
            loginField: $focusedField,
            isNewPassword: true,
            field: .password
        )
        .requirements(
            text: $viewModel.text,
            validatorType: PasswordInputValidator.self
        )
        .focused($focusedField, equals: .password)
        .submitLabel(.next)
        .onTapGesture {
            focusedField = .password
        }
    }
}

// MARK: - Preview
#Preview {
    AccountPasswordView(viewModel: .preview)
}
