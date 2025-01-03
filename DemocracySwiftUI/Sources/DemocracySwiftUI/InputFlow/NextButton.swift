//
//  NextButton.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/9/24.
//

import SharedSwiftUI
import SwiftUI

// A NextButton to be used as part of a user input flow.
public struct SubmittableNextButton<ViewModel: InputFlowViewModel>: View {
    @Bindable var viewModel: ViewModel
    
    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        NextButton(
            isShowingProgress: $viewModel.isShowingProgress,
            nextAction: { await viewModel.nextButtonAction() },
            isDisabled: !viewModel.nextButtonEnabled
        )
    }
}

@MainActor
struct NextButton: View {
    @Binding var isShowingProgress: Bool
    var nextAction: @MainActor () async -> Void
    var isDisabled: Bool
    
    var body: some View {
        AsyncButton(
            action: { await nextAction() },
            label: { Text("Next") },
            showProgressView: $isShowingProgress
        )
        .buttonStyle(PrimaryButtonStyle())
        .isDisabledWithAnimation(isDisabled: isDisabled)
    }
}

// MARK: - Preview
#Preview {
    NextButton(
        isShowingProgress: .constant(false),
        nextAction: {},
        isDisabled: false
    )
}
