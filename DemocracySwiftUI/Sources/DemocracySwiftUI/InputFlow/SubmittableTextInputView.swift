//
//  CreatePasswordView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/1/23.
//

import SwiftUI
import SharedSwiftUI

public struct SubmittableTextInputView<ViewModel: TextInputFlowViewModel, Content: View>: View {
    @Bindable var viewModel: ViewModel
    @FocusState.Binding var focusedField: ViewModel.CoordinatorViewModel.Flow?
    @ViewBuilder let content: Content
    
    public init(
        viewModel: ViewModel,
        focusedField: FocusState<ViewModel.CoordinatorViewModel.Flow?>.Binding,
        @ViewBuilder content: () -> Content
    ) {
        self.viewModel = viewModel
        self._focusedField = focusedField
        self.content = content()
    }
    
    public var body: some View {
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
    @Previewable @Environment(\.theme) var theme: Theme
    @Previewable @FocusState var focusedField: MockSubmittableViewModel.CoordinatorViewModel.Flow?
    
    SubmittableTextInputView(viewModel: MockSubmittableViewModel(), focusedField: $focusedField) {
        TextField(
            "Field Title",
            text: .constant("Hello World"),
            prompt: Text("Field Title").foregroundColor(theme.primaryColorScheme.tertiaryBackground)
        )
        .emailTextFieldStyle(
            email: .constant("Email Text"),
            focusedField: $focusedField,
            field: .mockOne
        )
    }
}
