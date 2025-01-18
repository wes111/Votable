//
//  SnappingHorizontalScrollView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/7/24.
//

import SwiftUI

public struct SnappingHorizontalScrollView<T: Hashable, Content: View>: View {
    @Environment(\.theme) var theme: Theme
    let snappingPadding = 60.0
    var scrollContent: [T]
    let content: (T) -> Content
    
    public init(
        scrollContent: [T],
        @ViewBuilder content: @escaping (T) -> Content
    ) {
        self.scrollContent = scrollContent
        self.content = content
    }
    
    public var body: some View {
        GeometryReader { geo in
            ScrollView(.horizontal) {
                LazyHStack(alignment: .top, spacing: 0) {
                    ForEach(scrollContent, id: \.self) { rule in
                        content(rule)
                            .frame(width: geo.size.width - (2 * snappingPadding))
                            .scrollTransition(.animated.threshold(.visible(0.5))) { content, phase in
                                content
                                    .opacity(phase.isIdentity ? 1 : 0.5)
                                    .scaleEffect(phase.isIdentity ? 1 : 0.8)
                                    .blur(radius: phase.isIdentity ? 0 : 1)
                            }
                    }
                }
                .scrollTargetLayout()
            }
            .animation(.easeOut(duration: theme.sizeConstants.animationLength), value: scrollContent)
            .contentMargins(.horizontal, snappingPadding, for: .scrollContent)
            .scrollTargetBehavior(.viewAligned)
            .scrollClipDisabled()
            .scrollIndicators(.hidden)
        }
    }
}

// MARK: - Preview
#Preview(traits: .standardPreviewModifier) {
    @Previewable @Environment(\.theme) var theme: Theme
    
    SnappingHorizontalScrollView(scrollContent: String.mockArray) { string in
        Text(string)
            .foregroundStyle(theme.primaryColorScheme.primaryText)
            .frame(width: 150, height: 50)
            .background(theme.primaryColorScheme.secondaryBackground)
    }
}
