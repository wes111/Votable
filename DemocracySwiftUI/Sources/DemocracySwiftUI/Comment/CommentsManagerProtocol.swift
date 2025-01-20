//
//  CommentsManagerProtocol.swift
//  DemocracySwiftUI
//
//  Created by Wesley Luntsford on 1/1/25.
//

import Foundation

@MainActor
public protocol CommentsManagerProtocol {
    var commentsTree: [CommentNode] { get }
    
    func fetchReplies(for parent: CommentNode?) async throws
    func submitComment(text: String, parent: CommentNode?) async throws
}
