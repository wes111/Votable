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
        AsyncButton(showProgressView: $viewModel.isShowingProgress) {
            await action()
        } label: {
            Label("Skip", systemImage: SystemImage.arrowRight.rawValue)
                .labelStyle(ReversedLabelStyle())
        }
        .disabled(viewModel.isShowingProgress)
        .buttonStyle(SecondaryButtonStyle())
    }
}

// MARK: - Preview
#Preview(traits: .standardPreviewModifier) {
    SubmittableNextAndSkipButtons(viewModel: MockSubmittableViewModel())
}
