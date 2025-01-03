//
//  CustomDivider.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/31/24.
//

import SwiftUI

public struct CustomDivider: View {
    @Environment(\.theme) var theme: Theme
    
    public init() {}
    
    public var body: some View {
        Divider()
            .overlay(theme.primaryColorScheme.tertiaryBackground)
    }
}

// MARK: - Preview
#Preview {
    CustomDivider()
}
