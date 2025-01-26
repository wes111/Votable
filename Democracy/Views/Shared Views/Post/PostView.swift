//
//  PostView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/7/23.
//

import DemocracySwiftUI
import Navigator
import SharedResourcesClientAndServer
import SharedSwiftUI
import SwiftUI

struct PostView: View {
    @Environment(\.theme) var theme: Theme
    @Environment(\.navigator) var navigator: Navigator
    @State private var viewModel: PostViewModel
    @FocusState private var isAddCommentFieldFocused: Bool?
    
    init(post: Post) {
        self.viewModel = .init(post: post, commentsManager: CommentsManager(post: post))
    }
    
    var body: some View {
        content
            .toolbarNavigation(
                leadingContent: leadingContent,
                centerContent: centerContent,
                trailingContent: trailingContent,
                theme: theme
            )
            .alertableModifier(alertModel: $viewModel.alertModel)
            .onChange(of: viewModel.replyingToComment) { _, newValue in
                isAddCommentFieldFocused = newValue != nil
            }
            .onChange(of: isAddCommentFieldFocused ?? false) { _, isFocused in
                if !isFocused {
                    viewModel.replyingToComment = nil
                }
            }
            .task {
                await viewModel.fetchInitialComments()
            }
    }
}

// MARK: - Subviews
private extension PostView {
    var content: some View {
        commentList
            .background(theme.primaryColorScheme.primaryBackground, ignoresSafeAreaEdges: .all)
            .dismissKeyboardOnDrag()
    }
    
    func listNode(_ commentNode: CommentNode) -> some View {
        Group {
            if commentNode.isLoadMoreNode {
                loadRepliesButton(for: commentNode.parentComment)
            } else {
                commentView(commentNode)
            }
        }
        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
        .listRowBackground(theme.primaryColorScheme.primaryBackground)
        .listRowSeparator(.hidden)
    }
    
    var commentList: some View {
        List {
            PostHeaderView(viewModel: viewModel.postHeaderViewModel)
                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                .listRowBackground(theme.primaryColorScheme.primaryBackground)
                .listRowSeparator(.hidden)
            
            ForEach(viewModel.comments) { commentNode in
                NodeOutlineGroup(node: commentNode, childKeyPath: \.replies) { commentNode in
                    listNode(commentNode)
                }
            }
        }
        .safeAreaInset(edge: .bottom) {
            AddCommentView(viewModel: viewModel, focusState: $isAddCommentFieldFocused)
        }
        .safeAreaPadding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .listStyle(.plain)
        .clipped()
        .disclosureGroupStyle(CommentDisclosureGroupStyle())
        .animation(.easeInOut)
    }
    
    func commentView(_ commentNode: CommentNode) -> some View {
        CommentView(viewModel: .init(
            comment: commentNode,
            delegate: viewModel)
        )
        .padding(.horizontal, theme.sizeConstants.screenPadding)
    }
    
    func loadRepliesButton(for comment: CommentNode?) -> some View {
        HStack {
            if let comment {
                ForEach(0...comment.depth, id: \.self) { _ in
                    CustomDivider()
                        .padding(.trailing, theme.sizeConstants.smallInnerBorder)
                }
            }
            
            AsyncButton(showProgressView: .constant(false)) {
                await viewModel.onTapLoadReplies(comment: comment)
            } label: {
                Text(viewModel.loadButtonText(for: comment))
            }
            .buttonStyle(TertiaryButtonStyle())
            .padding(.vertical, theme.sizeConstants.smallElementSpacing)
        }
        .padding(.horizontal, theme.sizeConstants.screenPadding)
    }
    
    var leadingContent: [TopBarContent] {
        [.back({ navigator.pop() })]
    }
    
    var centerContent: [TopBarContent] {
        [.title(viewModel.post.communityId, size: .small)]
    }
    
    var trailingContent: [TopBarContent] {
        [.menu([])]
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        PostView(post: .preview)
    }
}
