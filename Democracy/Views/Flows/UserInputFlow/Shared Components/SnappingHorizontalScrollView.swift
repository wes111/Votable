//
//  SnappingHorizontalScrollView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/7/24.
//

import SwiftUI
import SharedResourcesClientAndServer

struct SnappingHorizontalScrollView<T: Hashable, Content: View>: View {
    let snappingPadding = 60.0
    var scrollContent: [T]
    let content: (T) -> Content
    
    init(
        scrollContent: [T],
        @ViewBuilder content: @escaping (T) -> Content
    ) {
        self.scrollContent = scrollContent
        self.content = content
    }
    
    var body: some View {
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
            .animation(.easeOut(duration: ViewConstants.animationLength), value: scrollContent)
            .contentMargins(.horizontal, snappingPadding, for: .scrollContent)
            .scrollTargetBehavior(.viewAligned)
            .scrollClipDisabled()
            .scrollIndicators(.hidden)
        }
    }
}

// MARK: - Preview
#Preview {
    ZStack {
        Color.primaryBackground.ignoresSafeArea()
        SnappingHorizontalScrollView(scrollContent: Community.preview.rules) { rule in
            MenuCard(
                title: rule.title,
                description: rule.description
            ) {
                Button("Delete") { }
                Button("Edit") { }
            }
        }
    }
}
