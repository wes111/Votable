//
//  TightLabelStyle.swift
//  Democracy
//
//  Created by Wesley Luntsford on 6/3/23.
//

import SwiftUI

public struct TightLabelStyle: LabelStyle {
    @Environment(\.theme) var theme: Theme
    
    public init() {}
    
    public func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: theme.sizeConstants.extraSmallElementSpacing) {
            configuration.icon
            configuration.title
        }
    }
}

// MARK: - Preview
#Preview(traits: .standardPreviewModifier) {
    Label("11", systemImage: "arrow.down")
        .labelStyle(TightLabelStyle())
}
