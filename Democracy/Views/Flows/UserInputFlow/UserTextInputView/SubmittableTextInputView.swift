//
//  CreatePasswordView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/1/23.
//

import SwiftUI

@MainActor
struct SubmittableTextInputView<ViewModel: TextInputFlowViewModel, Content: View>: View {
    @Bindable var viewModel: ViewModel
    @FocusState.Binding var focusedField: ViewModel.CoordinatorViewModel.Flow?
    @ViewBuilder let content: Content
    
    init(
        viewModel: ViewModel,
        focusedField: FocusState<ViewModel.CoordinatorViewModel.Flow?>.Binding,
        @ViewBuilder content: () -> Content
    ) {
        self.viewModel = viewModel
        self._focusedField = focusedField
        self.content = content()
    }
    
    var body: some View {
        VStack {
            content
            Spacer()
            SubmittableNextAndSkipButtons(viewModel: viewModel)
        }
        .onSubmit {
            performAsnycTask(
                action: {
                    viewModel.text = viewModel.text.trimmingCharacters(in: .whitespacesAndNewlines)
                    await viewModel.onSubmit()
                },
                isShowingProgress: $viewModel.isShowingProgress
            )
        }
        .onAppear {
            focusedField = viewModel.focusedField
            viewModel.setUserInput()
        }
        .dismissKeyboardOnDrag()
    }
}

// MARK: - Preview
#Preview {
    @FocusState var focusedField: AccountFlow?
    
    SubmittableTextInputView(viewModel: AccountEmailViewModel.preview, focusedField: $focusedField) {
        TextField(
            "Field Title",
            text: .constant("Hello World"),
            prompt: Text("Field Title").foregroundColor(.tertiaryBackground)
        )
        .emailTextFieldStyle(
            email: .constant("Email Text"),
            focusedField: $focusedField,
            field: .email
        )
    }
}
