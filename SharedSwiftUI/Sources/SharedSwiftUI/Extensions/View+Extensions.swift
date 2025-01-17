//
//  View+Extensions.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/30/23.
//

import SwiftUI
import Combine

// https://stackoverflow.com/questions/65784294/how-to-detect-if-keyboard-is-present-in-swiftui
// Publishes a bool value indicating whether the keyboard is visible.
public extension View {
    
    @MainActor var keyboardPublisher: AnyPublisher<Bool, Never> {
        Publishers
            .Merge(
                NotificationCenter
                    .default
                    .publisher(for: UIResponder.keyboardWillShowNotification)
                    .map { _ in true },
                NotificationCenter
                    .default
                    .publisher(for: UIResponder.keyboardWillHideNotification)
                    .map { _ in false }
            )
            .eraseToAnyPublisher()
    }
}

public extension View { // TODO: This should be a view modifier, not an extension of view...
    func titledElement(title: String, theme: Theme) -> some View {
        return VStack(alignment: .leading, spacing: theme.sizeConstants.smallElementSpacing) {
            Text(title)
                .font(.system(.body, weight: .light))
                .foregroundColor(theme.primaryColorScheme.primaryText)
                .fixedSize(horizontal: false, vertical: true)
            self
        }
    }
}

// https://www.avanderlee.com/swiftui/conditional-view-modifier/
// Conditional ViewModifier.
public extension View {
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
