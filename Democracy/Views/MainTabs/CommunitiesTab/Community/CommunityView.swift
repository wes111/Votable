//
//  CommunityView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/26/23.
//

import SharedResourcesClientAndServer
import DemocracySwiftUI
import Navigator
import SharedSwiftUI
import SwiftUI

struct CommunityView: View {
    @State private var viewModel: CommunityViewModel
    @Environment(\.theme) var theme: Theme
    @Environment(\.navigator) var navigator: Navigator
    
    init(community: Community) {
        viewModel = .init(community: community)
    }
    
    var body: some View {
        content
            .background(theme.primaryColorScheme.primaryBackground, ignoresSafeAreaEdges: .all)
            .toolbarNavigation(
                leadingContent: leadingContent,
                centerContent: centerContent,
                trailingContent: trailingContent,
                theme: theme
            )
    }
}

// MARK: - Subviews
private extension CommunityView {
    var content: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                communityOverview
                    .padding(.bottom, 10)
                headerButtons
                communitySection
            }
        }
        .clipped()
    }
    
    var headerButtons: some View {
        VStack(spacing: theme.sizeConstants.smallInnerBorder) {
            HorizontalSelectableList(
                selection: Binding(
                    get: { SelectableCommunityTab(viewModel.selectedTab) },
                    set: { viewModel.selectedTab = $0.communityTab }
                )
            )
            .padding(.horizontal, theme.sizeConstants.screenPadding)
            .font(.callout)
            
            CustomDivider()
        }

    }
    
    var joinLeaveButton: some View {
        AsyncButton(showProgressView: $viewModel.isShowingProgress) {
            await viewModel.toggleCommunityMembership()
        } label: {
            Text(viewModel.membershipButtonTitle)
        }
        .buttonStyle(SmallSecondaryButtonStyle())
        .disabled(false)
    }
    
    @ViewBuilder
    var communitySection: some View {
        switch viewModel.selectedTab {
        case .feed:
            PostsFeedView(community: viewModel.community)
            
        case .info:
            CommunityInfoView(community: viewModel.community)
            
        case .archive:
            CommunityArchiveFeedView(community: viewModel.community)
            
        case .vote:
            EmptyView() // TODO: ...
            
        case .manage:
            EmptyView() // TODO: ...
        }
    }
    
    var communityOverview: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Circle()
                    .frame(width: 50, height: 50)
                    .foregroundStyle(theme.primaryColorScheme.secondaryText)
                
                VStack(alignment: .leading, spacing: theme.sizeConstants.extraSmallElementSpacing) {
                    Text(viewModel.community.name)
                        .foregroundStyle(theme.primaryColorScheme.secondaryText)
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    Text(viewModel.foundedText)
                        .foregroundStyle(theme.primaryColorScheme.secondaryText)
                        .font(.caption2)
                    
                    Text(viewModel.membersText)
                        .foregroundStyle(theme.primaryColorScheme.secondaryText)
                        .font(.caption2)
                }
                
                Spacer()
                
                joinLeaveButton
            }
            
            Text(viewModel.community.tagline)
                .foregroundStyle(theme.primaryColorScheme.secondaryText)
                .font(.footnote)
        }
        .padding(.horizontal, theme.sizeConstants.screenPadding)
    }
    
    var leadingContent: [TopBarContent] {
        [.back({ navigator.pop() })]
    }
    
    var centerContent: [TopBarContent] {
       [] // [.title(community.name, size: .large)]
    }
    
    var trailingContent: [TopBarContent] {
        [.menu([
            .init(title: "Create Post", action: { navigator.navigate(to: CommunityDestination.createPost(community: viewModel.community)) })
        ])]
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        CommunityView(community: .preview)
    }
}
