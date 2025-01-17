//
//  DisabledAnimationModifier.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/15/24.
//

import SwiftUI

fileprivate struct DisabledAnimationModifier: ViewModifier {
    @State private var isDisabledAnimated: Bool = true
    var isDisabled: Bool
    
    public init(isDisabled: Bool) {
        self.isDisabled = isDisabled
    }
    
    public func body(content: Content) -> some View {
        content
            .onAppear {
                isDisabledAnimated = isDisabled
            }
            .onChange(of: isDisabled, { _, newValue in
                withAnimation {
                    isDisabledAnimated = newValue
                }
            })
            .disabled(isDisabledAnimated)
    }
}

// MARK: - View Extension
public extension View {
    func isDisabledWithAnimation(isDisabled: Bool) -> some View {
        modifier(DisabledAnimationModifier(isDisabled: isDisabled))
    }
}
