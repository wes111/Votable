//
//  HorizontalProgressView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/23/24.
//

import SwiftUI

public struct HorizontalProgressView: View {
    @Environment(\.theme) var theme: Theme
    let totalProgress: Int
    let currentProgress: Int
    
    public init(totalProgress: Int, currentProgress: Int) {
        self.totalProgress = totalProgress
        self.currentProgress = currentProgress
    }
    
    public var body: some View {
        HStack(alignment: .center, spacing: 5) {
            ForEach((0...totalProgress - 1), id: \.self) { progress in
                let hasProgressed = progress <= currentProgress
                RoundedRectangle(cornerRadius: theme.sizeConstants.cornerRadius)
                    .fill(hasProgressed ? theme.primaryColorScheme.tertiaryText : theme.primaryColorScheme.secondaryBackground)
                    .frame(height: 3.5)
            }
        }
    }
}

// MARK: - Preview
#Preview(traits: .standardPreviewModifier) {
    HorizontalProgressView(totalProgress: 5, currentProgress: 2)
        .padding()
}
