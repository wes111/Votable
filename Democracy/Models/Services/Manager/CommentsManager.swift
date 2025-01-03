//
//  CommentsManager.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/1/25.
//

import DemocracySwiftUI
import Factory
import Foundation
import SharedResourcesClientAndServer

// MARK: - CommentsManager
// Note: `LoadMore` nodes are inserted into the `commentsTree` to identify where
// more comments or replies can be fetched.
@MainActor @Observable
final class CommentsManager: CommentsManagerProtocol {
    var commentsTree: [CommentNode] = []
    
    @ObservationIgnored @Injected(\.commentService) private var commentService
    private let post: Post
    
    init(post: Post) {
        self.post = post
    }
}

// MARK: - Methods
extension CommentsManager {
    
    func fetchReplies(for parent: CommentNode? = nil) async throws {
        guard let nodeArray = nodeArray(for: parent) else {
            return
        }
        
        if let lastFetchedNode = nodeArray.dropLast().last {
            try await fetchAdditionalComments(for: parent, lastFetchedComment: lastFetchedNode)
        } else {
            try await fetchInitialComments(for: parent)
        }
    }
    
    func submitComment(text: String, parent: CommentNode?) async throws {
        let comment = try await commentService.submitComment(
            parentId: parent?.value.id,
            postId: post.id,
            content: text
        )
        
        // This node cannot have replies, bc it was just created.
        let node = CommentNode(value: comment.toObservableComment(), parent: parent)
        
        if let parent {
            if let replies = parent.replies {
                if let lastComment = replies.last, lastComment.isLoadMoreNode {
                    parent.children = updatedChildrenWithLoadMore(
                        replies: replies, newNode: node, lastNode: lastComment
                    )
                } else {
                    // NOTE: Appending directly to `children` breaks observation,
                    // so we need to assign an array to `parent.children`.
                    parent.children = updatedChildrenWithoutLoadMore(replies: replies, newNode: node)
                }
            } else {
                parent.children = [node]
            }
        } else {
            if let lastComment = commentsTree.last, lastComment.isLoadMoreNode {
                commentsTree = updatedChildrenWithLoadMore(
                    replies: commentsTree, newNode: node, lastNode: lastComment
                )
            } else {
                commentsTree.append(node)
            }
        }
    }
}

// MARK: - Private Methods
private extension CommentsManager {
    
    // For root comments, the `parent` is nil.
    // Call this method once for root comments and no more than once per node.
    func fetchInitialComments(for parent: CommentNode? = nil) async throws {
        let request: CommentFetchRequest = if let parent {
            .initialChildComments(parentId: parent.value.id)
        } else {
            .initialRootComments(postId: post.id)
        }
        let comments = try await commentService.fetchComments(request: request)
        updateCommentsTree(comments, parent: parent)
    }
    
    func fetchAdditionalComments(for parent: CommentNode? = nil, lastFetchedComment: CommentNode) async throws {
        let request: CommentFetchRequest = if let parent {
            .childComments(parentId: parent.value.id, afterCommentId: lastFetchedComment.value.id)
        } else {
            .rootComments(postId: post.id, afterCommentId: lastFetchedComment.value.id)
        }
        let comments = try await commentService.fetchComments(request: request)
        
        if comments.isEmpty {
            removeLoadMoreNode(for: parent)
            return
        }
        updateCommentsTree(comments, parent: parent)
    }
    
    func nodeArray(for parent: CommentNode? = nil) -> [CommentNode]? {
        if let parent {
            parent.replies
        } else {
            commentsTree
        }
    }
    
    // Removing the `loadMore` node signifies that all replies have been fetched.
    func removeLoadMoreNode(for parent: CommentNode? = nil) {
        guard let nodeArray = nodeArray(for: parent), let lastNode = nodeArray.last, lastNode.isLoadMoreNode else {
            return
        }
        let updatedArray = Array(nodeArray.dropLast())
        
        if let parent {
            parent.children = updatedArray
        } else {
            commentsTree = updatedArray
        }
    }
    
    func updateCommentsTree(_ comments: [Comment], parent: CommentNode? = nil) {
        let nodeArray = comments.map { CommentNode(value: $0.toObservableComment(), parent: parent) }
        
        nodeArray.forEach { node in
            if node.value.responseCount > 0, node.children == nil {
                node.children = [CommentNode.loadMoreNode(parent: node)]
            }
        }
        
        if let parent {
            var updatedChildren: [CommentNode] = []
            if let replies = parent.replies {
                updatedChildren = Array(replies.dropLast())
            }
            updatedChildren.append(contentsOf: nodeArray)
            if comments.count == 25 {
                updatedChildren.append(CommentNode.loadMoreNode(parent: parent))
            }
            
            parent.children = updatedChildren
        } else {
            var updatedRootComments: [CommentNode] = Array(commentsTree.dropLast())
            updatedRootComments.append(contentsOf: nodeArray)
            if comments.count == 25 {
                updatedRootComments.append(CommentNode.loadMoreNode(parent: nil))
            }
            commentsTree = updatedRootComments
        }
    }
    
    func updatedChildrenWithLoadMore(replies: [CommentNode], newNode: CommentNode, lastNode: CommentNode) -> [CommentNode] {
        var updatedReplies = Array(replies.dropLast())
        updatedReplies.append(newNode)
        updatedReplies.append(lastNode)
        return updatedReplies
    }
    
    func updatedChildrenWithoutLoadMore(replies: [CommentNode], newNode: CommentNode) -> [CommentNode] {
        var updatedReplies = replies
        updatedReplies.append(newNode)
        return updatedReplies
    }
}
