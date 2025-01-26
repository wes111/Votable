//
//  PostViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/7/23.
//

import DemocracySwiftUI
import Foundation
import Factory
import SharedResourcesClientAndServer
import SharedSwiftUI

@MainActor
protocol PostCoordinatorDelegate: AnyObject {
    func goBack()
}

@MainActor @Observable
final class PostViewModel {
    var isFocused: Bool = false
    var isLoading: Bool = false
    var alertModel: NewAlertModel?
    var replyingToComment: CommentNode?
    var commentText: String = ""
    let post: Post
    private let commentsManager: CommentsManagerProtocol
    let postHeaderViewModel: PostHeaderViewModel
    
    init(post: Post, commentsManager: CommentsManagerProtocol) {
        self.post = post
        self.commentsManager = commentsManager
        postHeaderViewModel = PostHeaderViewModel(post: post)
    }
}

// MARK: - Computed Properties
extension PostViewModel {
    
    var replyText: String {
        if let replyingToComment {
            "Replying to \(replyingToComment.value.userId)"
        } else {
            "Adding a top-level comment"
        }
    }
    
    var comments: [CommentNode] {
        commentsManager.commentsTree
    }
}

// MARK: - Methods
extension PostViewModel {
    
    func submitComment() async {
        guard !commentText.isEmpty else {
            return
        }
        isFocused = false
        
        do {
            try await commentsManager.submitComment(text: commentText, parent: replyingToComment)
            commentText = ""
            replyingToComment = nil
        } catch {
            alertModel = PostAlert.submitCommentFailed.toNewAlertModel()
        }
    }
    
    func fetchInitialComments() async {
        do {
            try await commentsManager.fetchReplies(for: nil)
        } catch {
            alertModel = PostAlert.fetchInitialCommentsFailed.toNewAlertModel()
        }
    }
    
    func loadButtonText(for node: CommentNode?) -> String {
        if let node {
            "Load Replies (\(node.remainingRepliesToLoadCount))"
        } else {
            "Load Top-Level Replies (\(remainingTopLevelRepliesToLoadCount)"
        }
    }
}

private extension PostViewModel {
    var remainingTopLevelRepliesToLoadCount: Int {
        post.commentCount - comments.count
    }
}

// MARK: - Protocol Conformance
extension PostViewModel: CommentViewModelDelegate {
    
    func onTapCommentReply(comment: CommentNode) {
        replyingToComment = comment
    }
    
    func onTapLoadReplies(comment: CommentNode?) async {
        do {
            try await commentsManager.fetchReplies(for: comment)
        } catch {
            print(error) // TODO: Show alert?
        }
    }
}
