//
//  FilterablePostsFeedView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/15/24.
//

import Navigator
import SharedResourcesClientAndServer
import SharedSwiftUI
import SwiftUI

struct FilterablePostsFeedView: View {
    @State private var viewModel: PostsFeedViewModel
    @Environment(\.theme) var theme: Theme
    @Environment(\.navigator) var navigator: Navigator
    
    init(community: Community, filters: PostFilters) {
        viewModel = .init(community: community, postFilters: filters)
    }
    
    var body: some View {
        content
            .background(theme.primaryColorScheme.primaryBackground, ignoresSafeAreaEdges: .all)
            .toolbarNavigation(
                leadingContent: leadingBarContent,
                centerContent: centerToolbarContent,
                trailingContent: trailingToolbarContent,
                theme: theme
            )
            .dynamicHeightSheet(isShowingSheet: $viewModel.isShowingFilters) {
                FilterPostsView(viewModel: viewModel.filterPostsViewModel)
                    .presentationDragIndicator(.visible)
                    .background(theme.primaryColorScheme.secondaryBackground, ignoresSafeAreaEdges: .all)
                    .interactiveDismissDisabled()
            }
    }
}

// MARK: - Subviews
private extension FilterablePostsFeedView {
    
    var content: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                PostsFeedView(community: viewModel.community)
            }
        }
        .clipped()
    }
    
    var leadingBarContent: [TopBarContent] {
        [.back({ navigator.pop() })]
    }
    
    var centerToolbarContent: [TopBarContent] {
        [.title(viewModel.categoryName, size: .small)]
    }
    
    var trailingToolbarContent: [TopBarContent] {
        [.filter({ viewModel.isShowingFilters = true })] // TODO: filter logic
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        FilterablePostsFeedView(community: .preview, filters: .preview)
    }
}
