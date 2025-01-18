//
//  TaggableModifier.swift
//  Democracy
//
//  Created by Wesley Luntsford on 9/17/23.
//

import SwiftUI
import SharedSwiftUI

struct TagModifier: ViewModifier {
    @Environment(\.theme) var theme: Theme
    let backgroundColor: Color
    
    func body(content: Content) -> some View {
        content
            .padding(theme.sizeConstants.smallInnerBorder)
            .background(backgroundColor, in: RoundedRectangle(cornerRadius: theme.sizeConstants.cornerRadius))
            .foregroundStyle(theme.primaryColorScheme.secondaryText)
    }
}

// MARK: - View Extension
public extension View {
    func tagModifier(backgroundColor: Color? = nil) -> some View {
        @Environment(\.theme) var theme: Theme
        return modifier(TagModifier(backgroundColor: backgroundColor ?? theme.primaryColorScheme.secondaryBackground))
    }
}

// MARK: - Preview
#Preview(traits: .standardPreviewModifier) {
    
    Text("Tag")
        .tagModifier()
}
