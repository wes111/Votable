//
//  PostHeaderView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 6/26/24.
//

import DemocracySwiftUI
import SharedSwiftUI
import SwiftUI

@MainActor
struct PostHeaderView: View {
    @Environment(\.theme) var theme: Theme
    @State private var viewModel: PostHeaderViewModel
    
    init(viewModel: PostHeaderViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        content
    }
}

// MARK: - Subviews
private extension PostHeaderView {
    var content: some View {
        VStack(spacing: theme.sizeConstants.elementSpacing) {
            VStack(alignment: .leading, spacing: theme.sizeConstants.elementSpacing) {
                topLineMetadata
                title
                bodyText
                if let linkProviderViewModel = viewModel.linkProviderViewModel {
                    customLink(viewModel: linkProviderViewModel)
                }
                tags
                bottomButtonsRow
            }
            .padding(.horizontal, theme.sizeConstants.screenPadding)
        }
    }
    
    var topLineMetadata: some View {
        HStack(spacing: theme.sizeConstants.smallElementSpacing) {
            Text(viewModel.post.categoryName)
                .tagModifier(backgroundColor: theme.primaryColorScheme.primaryAccent)
            
            VStack(alignment: .leading, spacing: theme.sizeConstants.extraSmallElementSpacing) {
                Text(viewModel.post.userId)
                    .foregroundStyle(theme.primaryColorScheme.secondaryText)
                    .font(.footnote)
                
                Text("\(viewModel.date)")
                    .foregroundStyle(theme.primaryColorScheme.secondaryText)
                    .fontWeight(.light)
                    .font(.caption2)
            }
        }
    }
    
    var tags: some View {
        TagsFlow(
            selectedItems: [],
            items: viewModel.selectableCommunityTags,
            tagAction: .none
        )
    }
    
    var title: some View {
        Text(viewModel.post.title)
            .foregroundStyle(theme.primaryColorScheme.primaryText)
            .font(.title3)
            .fontWeight(.bold)
    }
    
    var bodyText: some View {
        Text(viewModel.post.body)
            .foregroundStyle(theme.primaryColorScheme.secondaryText)
            .font(.footnote)
    }
    
    func customLink(viewModel: LinkProviderViewModel) -> some View {
        CustomLinkProviderView(viewModel: viewModel)
            .frame(height: 100)
    }
    
    var bottomButtonsRow: some View {
        HStack(spacing: 0) {
            commentsCount
            
            VoteButtons(
                didTapVoteButton: viewModel.onTapVoteButton(_:),
                upVoteCount: viewModel.upVoteCount,
                downVoteCount: viewModel.downVoteCount
            )
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
    
    var commentsCount: some View {
        Label(viewModel.commentsText, systemImage: SystemImage.bubble.rawValue)
            .font(.footnote)
            .foregroundStyle(theme.primaryColorScheme.secondaryText)
            .labelStyle(TightLabelStyle())
    }
}

// MARK: - Preview
#Preview {
    @Previewable @Environment(\.theme) var theme: Theme
    ZStack {
        theme.primaryColorScheme.primaryBackground.ignoresSafeArea()
        PostHeaderView(viewModel: .preview)
    }
}
