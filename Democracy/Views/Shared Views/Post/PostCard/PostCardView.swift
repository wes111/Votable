//
//  PostCardView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/8/23.
//

import DemocracySwiftUI
import SharedSwiftUI
import SwiftUI

@MainActor
struct PostCardView: View {
    @Environment(\.theme) var theme: Theme
    @State private var viewModel: PostCardViewModel
    
    init(viewModel: PostCardViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        content
    }
}

// MARK: - Subviews
private extension PostCardView {
    
    var content: some View {
        Button {
            viewModel.goToPostView()
        } label: {
            VStack(alignment: .leading, spacing: theme.sizeConstants.smallElementSpacing) {
                header
                title
                if let linkProviderViewModel = viewModel.linkProviderViewModel {
                    customLink(viewModel: linkProviderViewModel)
                }
                bottomButtonsRow
            }
            .padding(.horizontal, theme.sizeConstants.screenPadding)
            .padding(.vertical, theme.sizeConstants.largeElementSpacing)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
    
    var title: some View {
        Text(viewModel.post.title)
            .foregroundStyle(theme.primaryColorScheme.secondaryText)
            .font(.headline)
            .fontWeight(.semibold)
    }
    
    func customLink(viewModel: LinkProviderViewModel) -> some View {
        CustomLinkProviderView(viewModel: viewModel)
            .frame(height: 75)
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
    
    var header: some View {
        HStack(alignment: .center, spacing: theme.sizeConstants.smallElementSpacing) {
           userIcon
            
            VStack(alignment: .leading, spacing: 0) {
                headerTopLine
                headerBottomLine
            }
        }
    }
    
    var headerTopLine: some View {
        HStack(spacing: theme.sizeConstants.elementSpacing) {
            Text(viewModel.username)
            Spacer()
            menuButton
        }
        .foregroundStyle(theme.primaryColorScheme.secondaryText)
        .font(.caption2)
    }
    
    var headerBottomLine: some View {
        HStack(alignment: .center, spacing: theme.sizeConstants.extraSmallElementSpacing) {
            Text(viewModel.userTagline)
            Text("•")
            Text(viewModel.date)
        }
        .foregroundStyle(theme.primaryColorScheme.secondaryText)
        .font(.caption2)
    }
    
    var userIcon: some View {
        Circle()
            .frame(width: 25, height: 25)
            .foregroundStyle(theme.primaryColorScheme.secondaryText)
    }
    
    var menuButton: some View {
        Button {
            viewModel.onTapMenuButton()
        } label: {
            Image(systemName: SystemImage.ellipsis.rawValue)
        }
        .buttonStyle(.plain)
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
        theme.primaryColorScheme.primaryBackground
        PostCardView(viewModel: PostCardViewModel.preview)
    }
}
