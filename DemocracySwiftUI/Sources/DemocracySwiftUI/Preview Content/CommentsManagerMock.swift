//
//  CommentsManagerMock.swift
//  DemocracySwiftUI
//
//  Created by Wesley Luntsford on 1/1/25.
//

import Foundation

public final class CommentsManagerMock: CommentsManagerProtocol {
    public var commentsTree: [CommentNode] = []
    
    public init() {}
    
    public func fetchReplies(for parent: CommentNode?) async throws {
        return
    }
    
    public func submitComment(text: String, parent: CommentNode?) async throws {
        return
    }
}
