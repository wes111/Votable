//
//  FilterPostsView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/21/24.
//

import DemocracySwiftUI
import SharedResourcesClientAndServer
import SharedSwiftUI
import SwiftUI

enum FilterPostsPath {
    case sortOrder
    case dateFilter
    case categoriesFilter
}

struct FilterPostsView: View {
    @Bindable var viewModel: FilterPostsViewModel
    @Environment(\.dismiss) var dismiss
    @Environment(\.theme) var theme: Theme
    @State private var height: CGFloat = .zero
    
    var body: some View {
        navigationStack
    }
}

// MARK: - Subviews
private extension FilterPostsView {
    
    var content: some View {
        VStack(alignment: .leading, spacing: theme.sizeConstants.elementSpacing) {
            selectablePickerViews
            applyButton
        }
        .frame(maxHeight: .infinity, alignment: .topLeading)
        .background(theme.primaryColorScheme.secondaryBackground, ignoresSafeAreaEdges: .all)
        .toolbarNavigation(
            leadingContent: leadingToolbarContent,
            trailingContent: trailingToolbarContent,
            theme: theme
        )
    }
    
    var title: some View {
        Text("Filter and Sort Posts")
            .standardScreenTitle()
            .multilineTextAlignment(.leading)
    }
    
    var selectablePickerViews: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.sizeConstants.largeElementSpacing) {
                CustomDivider()
                
                tappableItem(selection: viewModel.selectableSortOrder, path: .sortOrder)
                    .padding(.horizontal, theme.sizeConstants.screenPadding)
                
                CustomDivider()
                
                tappableItem(selection: viewModel.selectableDateFilter, path: .dateFilter)
                    .padding(.horizontal, theme.sizeConstants.screenPadding)
                
                CustomDivider()
                
                TappableListItem(title: "Tags Filter", subtitle: viewModel.categoriesSubtitle, image: .tag) {
                    viewModel.navigateToPath(.categoriesFilter)
                }
                .padding(.horizontal, theme.sizeConstants.screenPadding)
                
                CustomDivider()
            }
        }
        .contentMargins(.top, theme.sizeConstants.scrollViewTopContentMargin)
        .scrollBounceBehavior(.basedOnSize, axes: [.vertical])
    }
    
    func tappableItem<T: Selectable>(selection: T, path: FilterPostsPath) -> some View {
        TappableListItem(title: T.metaTitle, subtitle: selection.title, image: T.metaImage) {
            viewModel.navigateToPath(path)
        }
    }
    
    var applyButton: some View {
        Button {
            viewModel.onTapUpdateFilters()
        } label: {
            Text("Apply")
        }
        .buttonStyle(PrimaryButtonStyle())
        .padding(theme.sizeConstants.screenPadding)
    }
}

// MARK: - Navigation Subviews
private extension FilterPostsView {
    
    var navigationStack: some View {
        NavigationStack(path: $viewModel.router.navigationPath) {
            content
                .navigationDestination(for: FilterPostsPath.self) { path in
                    navigationScreen(path: path)
                }
        }
        .frame(height: 450)
    }
    
    var trailingToolbarContent: [TopBarContent] {
        [.close({ dismiss() })]
    }
    
    var leadingToolbarContent: [TopBarContent] {
        [.title("Sort & Filter", size: .large)]
    }
    
    @ViewBuilder
    func navigationScreen(path: FilterPostsPath) -> some View {
        switch path {
        case .sortOrder:
            SelectablePickerDetailNavigationView(
                selectedCategory: Binding(
                    get: { SelectableSortOrderOption(viewModel.postFilters.sortOrder) },
                    set: { viewModel.postFilters.sortOrder = $0.sortOrderOption }
                ),
                backAction: viewModel.backAction
            )
            
        case .dateFilter:
            SelectablePickerDetailNavigationView(
                selectedCategory: Binding(
                    get: { SelectableDateFilter(viewModel.postFilters.dateFilter) },
                    set: { viewModel.postFilters.dateFilter = $0.dateFilter }
                ),
                backAction: viewModel.backAction
            )
            
        case .categoriesFilter:
            TagsPickerNavigationView(
                backAction: viewModel.backAction,
                toggleTagAction: viewModel.toggleTag,
                availableTags: viewModel.communityTags,
                selectedTags: viewModel.selectedTags
            )
        }
    }
}

// MARK: - Preview
#Preview {
    FilterPostsView(viewModel: .preview)
}
