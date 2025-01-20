//
//  CommentView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 5/11/24.
//

import DemocracySwiftUI
import SharedSwiftUI
import SwiftUI

@MainActor
struct CommentView: View {
    @Environment(\.theme) var theme: Theme
    @Bindable var viewModel: CommentViewModel
    
    var body: some View {
        primaryContent
    }
}

// MARK: - Subviews
private extension CommentView {
    
    var primaryContent: some View {
        HStack {
            ForEach(0..<viewModel.commentNode.depth, id: \.self) { _ in
                CustomDivider()
                    .padding(.trailing, theme.sizeConstants.smallInnerBorder)
            }
            
            VStack(alignment: .leading, spacing: theme.sizeConstants.smallElementSpacing) {
                header
                commentText
                footer
            }
            .padding(.vertical, theme.sizeConstants.smallElementSpacing)
        }
    }
    
    var commentText: some View {
        Text(viewModel.content)
            .foregroundStyle(theme.primaryColorScheme.secondaryText)
            .font(.footnote)
            .frame(maxWidth: .infinity, alignment: .leading)
            .fixedSize(horizontal: false, vertical: true)
    }
}

// MARK: - Header
private extension CommentView {
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
            replyButton
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
    
    var replyButton: some View {
        Button {
            viewModel.didTapReplyButton()
        } label: {
            Label {
                Text("Reply")
            } icon: {
                Image(systemName: SystemImage.arrowshapeTurnUpLeft.rawValue)
            }
            .labelStyle(TightLabelStyle())
        }
        .buttonStyle(.plain)
        /*
         Hack: `.buttonStyle(.plain)` prevents the disclosure group from expanding/collapsing.
         Read more here: https://stackoverflow.com/questions/56561064/swiftui-multiple-buttons-in-a-list-row
         */
    }
    
    var menuButton: some View {
        Button {
            viewModel.didTapMenuButton()
        } label: {
            Image(systemName: SystemImage.ellipsis.rawValue)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Footer
private extension CommentView {
    
    var footer: some View {
        HStack {
            VoteButtons(
                didTapVoteButton: viewModel.didTapVoteButton(_:),
                upVoteCount: viewModel.upVoteCount,
                downVoteCount: viewModel.downVoteCount
            )
            
            Spacer()
        }
    }
}

// MARK: - Preview
#Preview {
    @Previewable @Environment(\.theme) var theme: Theme
    ZStack {
        theme.primaryColorScheme.primaryBackground.ignoresSafeArea()
        CommentView(viewModel: .preview)
            .padding()
    }
}
