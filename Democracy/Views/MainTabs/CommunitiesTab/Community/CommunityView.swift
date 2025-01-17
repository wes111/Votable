//
//  CommunityView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/26/23.
//

import DemocracySwiftUI
import SharedSwiftUI
import SwiftUI

@MainActor
struct CommunityView: View {
    @State private var viewModel: CommunityViewModel
    @Environment(\.theme) var theme: Theme
    
    init(viewModel: CommunityViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        content
            .background(theme.primaryColorScheme.primaryBackground, ignoresSafeAreaEdges: .all)
            .toolbarNavigation(
                leadingContent: viewModel.leadingContent,
                centerContent: viewModel.centerContent,
                trailingContent: viewModel.trailingContent,
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
        AsyncButton(
            action: {
                await viewModel.toggleCommunityMembership()
            },
            label: {
                Text(viewModel.membershipButtonTitle)
            },
            showProgressView: $viewModel.isShowingProgress
        )
        .buttonStyle(SmallSecondaryButtonStyle())
        .disabled(false)
    }
    
    @ViewBuilder
    var communitySection: some View {
        switch viewModel.selectedTab {
        case .feed:
            PostsFeedView(viewModel: viewModel.communityHomeFeedViewModel())
            
        case .info:
            CommunityInfoView(viewModel: viewModel.communityInfoViewModel())
            
        case .archive:
            CommunityArchiveFeedView(viewModel: viewModel.communityArchiveViewModel())
            
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
}

// MARK: - Preview
#Preview {
    NavigationStack {
        CommunityView(viewModel: CommunityViewModel.preview)
    }
}
