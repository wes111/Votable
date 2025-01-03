//
//  Node.swift
//  Democracy
//
//  Created by Wesley Luntsford on 4/24/24.
//

import Foundation
import SharedSwift

public final class CommentNode: Node<ObservableComment>, Identifiable {
    
    public var id: String {
        value.id + (parent?.value.id ?? "")
    }
    
    public var replies: [CommentNode]? {
        // swiftlint:disable:next force_cast
        children as! [CommentNode]?
    }
    
    public var parentComment: CommentNode? {
        // swiftlint:disable:next force_cast
        parent as! CommentNode?
    }
    
    public static func loadMoreNode(parent: CommentNode?) -> CommentNode {
        let comment = ObservableComment(
            id: "end",
            parentId: "",
            postId: "",
            userId: "",
            creationDate: .now,
            content: "",
            upVoteCount: 0,
            downVoteCount: 0,
            responseCount: 0,
            score: 0
        )
        return CommentNode(value: comment, parent: parent)
    }
    
    public var isLoadMoreNode: Bool {
        id.hasPrefix("end")
    }
    
    public var remainingRepliesToLoadCount: Int {
        value.responseCount - (children?.count ?? 0) + 1 // Offset of one to account for load button "child"
    }
}
