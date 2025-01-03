//
//  PlainListView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 4/14/24.
//

import SwiftUI

// A plain `List` View that removes the standard formatting from a default `List`.
// Make user to use `List` instead of `LazyVStack` for reusable cells (memory).
// https://www.reddit.com/r/SwiftUI/comments/xzluon/list_is_a_pain_in_the_ass/
@MainActor
public struct PlainListView<ItemView: View, Item: Identifiable>: View {
    @Environment(\.theme) var theme: Theme
    var items: [Item]
    @ViewBuilder let content: (Item) -> ItemView
    
    public init(
        items: [Item],
        @ViewBuilder content: @escaping (Item) -> ItemView
    ) {
        self.items = items
        self.content = content
    }
    
    public var body: some View {
        List(items) { post in
            content(post)
                .listRowInsets(.init(
                    top: 0,
                    leading: 0,
                    bottom: theme.sizeConstants.smallElementSpacing,
                    trailing: 0
                ))
                .listRowBackground(theme.primaryColorScheme.primaryBackground)
                .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
    }
}

// A `ViewModifier` version of `PlainListView`
struct PlainListModifier: ViewModifier {
    @Environment(\.theme) var theme: Theme
    
    func body(content: Content) -> some View {
        List {
            content
                .listRowInsets(.init(
                    top: 0,
                    leading: 0,
                    bottom: theme.sizeConstants.smallElementSpacing,
                    trailing: 0
                ))
                .listRowBackground(theme.primaryColorScheme.primaryBackground)
                .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .clipped()
    }
}

// MARK: View Extension
public extension View {
    func plainListModifier() -> some View {
        modifier(PlainListModifier())
    }
}

// MARK: - Preview
//#Preview {
//    ZStack {
//        Color.primaryBackground.ignoresSafeArea(.all)
//        
//        PlainListView(
//            items: Post.previewArray.map { $0.toViewModel(coordinator: nil) },
//            content: { post in
//                PostCardView(viewModel: post)
//            })
//    }
//}
