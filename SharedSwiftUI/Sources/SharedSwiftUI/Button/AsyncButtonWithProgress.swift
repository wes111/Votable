//
//  AsyncButtonWithProgress.swift
//  SharedSwiftUI
//
//  Created by Wesley Luntsford on 12/30/24.
//

import SwiftUI

// Use this async button when the `ProgressView` should be confined to the button.
public struct AsyncButtonWithProgress<Label: View>: View {
    @State private var shouldStartAsyncTask: Bool = false
    @Environment(\.theme) var theme: Theme
    @State private var isDisabled: Bool = false
    @ViewBuilder var label: () -> Label
    var action: () async -> Void
    
    public init(
        action: @escaping () async -> Void,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self.action = action
        self.label = label
    }

    public var body: some View {
        Button {
            shouldStartAsyncTask = true
        } label: {
            ZStack {
                label()
                    .opacity(isDisabled ? 0.0 : 1.0)
                
                ProgressView()
                    .tint(theme.primaryColorScheme.secondaryText)
                    .opacity(isDisabled ? 1.0 : 0.0)
            }
        }
        .allowsHitTesting(!isDisabled)
        .disabled(isDisabled)
        .task(id: shouldStartAsyncTask) {
            guard shouldStartAsyncTask else {
                return
            }
            isDisabled = true
            await action()
            shouldStartAsyncTask = false
            isDisabled = false
        }
    }
}

// MARK: - Preview
#Preview(traits: .standardPreviewModifier) {
    
    AsyncButtonWithProgress {
        try? await Task.sleep(nanoseconds: 5_000_000_000)
    } label: {
        Text("Start Async Task")
    }
}
