//
//  AsyncButtonWithProgress.swift
//  SharedSwiftUI
//
//  Created by Wesley Luntsford on 12/30/24.
//

import SwiftUI

// Use this async button when the `ProgressView` should be confined to the button.
public struct AsyncButtonWithProgress<Label: View>: View {
    @Environment(\.theme) var theme: Theme
    @State private var isDisabled: Bool = false
    @ViewBuilder var label: () -> Label
    var action: () async -> Void
    
    public init(action: @escaping () async -> Void, @ViewBuilder label: @escaping () -> Label) {
        self.action = action
        self.label = label
    }

    public var body: some View {
        Button(
            action: {
                
                isDisabled = true
                
                Task {
                    var progressViewTask: Task<Void, Error>?
                    
                    progressViewTask = Task {
                        try await Task.sleep(nanoseconds: 150_000_000)
                    }
                    
                    await action()
                    progressViewTask?.cancel()
                    
                    Task { // Fixes bug where progressView is not dismissed.
                        try await Task.sleep(nanoseconds: 150_000)
                        withAnimation {
                            isDisabled = false
                        }
                    }
                }
            },
            label: {
                ZStack {
                    label()
                        .opacity(isDisabled ? 0.0 : 1.0)
                    
                    ProgressView()
                        .tint(theme.primaryColorScheme.secondaryText)
                        .opacity(isDisabled ? 1.0 : 0.0)
                }
            }
        )
        .animation(.easeInOut, value: isDisabled)
        .allowsHitTesting(!isDisabled)
        .disabled(isDisabled)
    }
}

// MARK: - Preview
#Preview {
    AsyncButtonWithProgress {
        return
    } label: {
        Text("Press Me")
    }

}
