//
//  SubmittableNextAndSkipButtons.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/9/24.
//

import SharedSwiftUI
import SwiftUI

public enum SkipAction {
    case nonSkippable
    case canSkip(action: () async -> Void)
}

public struct SubmittableNextAndSkipButtons<ViewModel: InputFlowViewModel>: View {
    @Bindable var viewModel: ViewModel
    
    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        ZStack {
            if case .canSkip(let action) = viewModel.skipAction, !viewModel.nextButtonEnabled {
                skipButton(action: action)
            } else {
                SubmittableNextButton(viewModel: viewModel)
            }
        }
        // Wait to draw the button until the view has properly placed the button.
        .geometryGroup()
        .animation(.easeInOut, value: viewModel.nextButtonEnabled)
    }
    
    func skipButton(action: @escaping () async -> Void) -> some View {
        AsyncButton(
            action: action,
            label: {
                Label("Skip", systemImage: SystemImage.arrowRight.rawValue)
                    .labelStyle(ReversedLabelStyle())
            },
            showProgressView: $viewModel.isShowingProgress
        )
        .disabled(viewModel.isShowingProgress)
        .buttonStyle(SecondaryButtonStyle())
    }
}

// MARK: - Preview
#Preview {
    SubmittableNextAndSkipButtons(viewModel: MockSubmittableViewModel())
}