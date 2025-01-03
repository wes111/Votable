//
//  PrimaryTitleModifier.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/23/24.
//

import SwiftUI

struct StandardScreenTitleModifier: ViewModifier {
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
#Preview {
    @Previewable @Environment(\.theme) var theme: Theme
    
    ZStack {
        theme.primaryColorScheme.primaryBackground.ignoresSafeArea()
        Text("Hello World")
            .standardScreenTitle()
    }
}
