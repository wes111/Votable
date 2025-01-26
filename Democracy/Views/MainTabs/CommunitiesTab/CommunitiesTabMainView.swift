//
//  CommunitiesTabMainView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/23.
//

import DemocracySwiftUI
import SharedSwiftUI
import SwiftUI
import Navigator

struct CommunitiesTabMainView: View {
    @Environment(\.theme) var theme: Theme
    @Environment(\.navigator) var navigator: Navigator
    @State private var viewModel: CommunitiesTabMainViewModel
    
    init() {
        viewModel = .init()
    }
    
    var body: some View {
        content
            .toolbarNavigation(
                leadingContent: leadingButtons,
                trailingContent: trailingButtons,
                theme: theme
            )
            .background(theme.primaryColorScheme.primaryBackground, ignoresSafeAreaEdges: .all)
            .progressModifier(isShowingProgess: $viewModel.isShowingProgress)
            .onChange(of: viewModel.category) { _, category in
                viewModel.fetchCommunitiesByCategory(category)
            }
            .onAppear {
                viewModel.onAppear()
            }
            .refreshable {
                await viewModel.forceRefreshMemberships()
            }
    }
}

// MARK: - Subviews
private extension CommunitiesTabMainView {
    
    var menuOptions: [MenuButtonOption] {
        [.init(
            title: "Create Community",
            action: { navigator.navigate(to: CommunityDestination.createCommunity) })]
    }
    
    var trailingButtons: [TopBarContent] {
        [.search({}), .menu(menuOptions)]
    }
    
    var leadingButtons: [TopBarContent] {
        [.title("Communities", size: .large)]
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: theme.sizeConstants.elementSpacing) {
            HorizontalSelectableList(
                selection: Binding(
                    get: { SelectableCommunitiesCategory(viewModel.category) },
                    set: { viewModel.category = $0.communitiesCategory }
                )
            )
            communityList
        }
        .padding(.horizontal, theme.sizeConstants.screenPadding)
    }
    
    var communityList: some View {
        PlainListView(items: viewModel.allCommunities) { community in
            TappableListItem(title: community.name, subtitle: community.tagline) {
                navigator.navigate(to: CommunityDestination.communityHome(community))
            }
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        CommunitiesTabMainView()
    }
}
