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
            viewModel.shouldPerformOnSubmit = true
        }
        .onAppear {
            focusedField = viewModel.focusedField
            viewModel.setUserInput()
        }
        .dismissKeyboardOnDrag()
        .task(id: viewModel.shouldPerformOnSubmit) {
            guard viewModel.shouldPerformOnSubmit else {
                return
            }
            viewModel.isShowingProgress = true
            viewModel.text = viewModel.text.trimmingCharacters(in: .whitespacesAndNewlines)
            await viewModel.onSubmit()
            viewModel.isShowingProgress = false
            viewModel.shouldPerformOnSubmit = false
        }
    }
}

// MARK: - Preview
#Preview(traits: .standardPreviewModifier) {
    @Previewable @State var text: String = "Mock Text"
    @Previewable @FocusState var focusedField: MockSubmittableViewModel.CoordinatorViewModel.Flow?
    
    SubmittableTextInputView(viewModel: MockSubmittableViewModel(), focusedField: $focusedField) {
        TextField(
            "Field Title",
            text: $text
        )
        .emailTextFieldStyle(
            email: $text,
            focusedField: $focusedField,
            field: .mockOne
        )
    }
}
