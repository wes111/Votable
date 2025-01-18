//
//  CustomProgressView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/30/23.
//

import SwiftUI

public struct CustomProgressView: View {
    @Environment(\.theme) var theme: Theme
    
    public init() {}
    
    public var body: some View {
        ProgressView()
            .controlSize(.large)
            .tint(theme.primaryColorScheme.secondaryText)
    }
}

// MARK: - Preview
#Preview(traits: .standardPreviewModifier) {
    CustomProgressView()
}
