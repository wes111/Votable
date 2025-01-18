//
//  AsyncButton.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/26/23.
//

import SwiftUI

public struct AsyncButton<Label: View>: View {
    @State private var shouldStartAsyncTask: Bool = false
    @ViewBuilder var label: () -> Label
    @Binding var showProgressView: Bool
    var action: () async -> Void
    
    public init(
        showProgressView: Binding<Bool>,
        action: @escaping () async -> Void,
        label: @escaping () -> Label
    ) {
        self._showProgressView = showProgressView
        self.action = action
        self.label = label
    }

    public var body: some View {
        Button {
            shouldStartAsyncTask = true
        } label: {
            label()
        }
        .isDisabledWithAnimation(isDisabled: showProgressView)
        .task(id: shouldStartAsyncTask) {
            guard shouldStartAsyncTask else {
                return
            }
            showProgressView = true
            await action()
            shouldStartAsyncTask = false
            showProgressView = false
        }
    }
}

// MARK: - Preview
#Preview(traits: .standardPreviewModifier) {
    @Previewable @State var showProgress = false
    
    VStack {
        AsyncButton(showProgressView: $showProgress) {
            try? await Task.sleep(nanoseconds: 5_000_000_000)
        } label: {
            Text("Start Async Task")
        }
        
        if showProgress {
            CustomProgressView()
        }
    }

}
