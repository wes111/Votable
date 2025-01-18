//
//  PrimaryTitleModifier.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/23/24.
//

import SwiftUI

fileprivate struct StandardScreenTitleModifier: ViewModifier {
    @Environment(\.theme) var theme: Theme
    
    func body(content: Content) -> some View {
        content
            .font(.system(.title, weight: .semibold))
            .foregroundColor(theme.primaryColorScheme.primaryText)
    }
}

// MARK: - View Extension
public extension Text {
    func standardScreenTitle() -> some View {
        self.modifier(StandardScreenTitleModifier())
    }
}

// MARK: - Preview
#Preview(traits: .standardPreviewModifier) {
    
    Text("Hello World")
        .standardScreenTitle()
}
