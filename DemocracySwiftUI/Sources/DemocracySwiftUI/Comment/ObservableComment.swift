//
//  ObservableComment.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/23/24.
//

import Foundation
import SharedResourcesClientAndServer
import SharedSwift

@Observable
public final class ObservableComment: Identifiable, Hashable, Votable {
    public let id: String
    public let parentId: String?
    public let postId: String
    public let userId: String
    public let creationDate: Date
    public let content: String
    public var upVoteCount: Int
    public var downVoteCount: Int
    public var score: Int
    public let responseCount: Int
    public var userVote: CommentVote?
    
    public init(
        id: String,
        parentId: String?,
        postId: String,
        userId: String,
        creationDate: Date,
        content: String,
        upVoteCount: Int,
        downVoteCount: Int,
        responseCount: Int,
        score: Int
    ) {
        self.id = id
        self.parentId = parentId
        self.postId = postId
        self.userId = userId
        self.creationDate = creationDate
        self.content = content
        self.upVoteCount = upVoteCount
        self.downVoteCount = downVoteCount
        self.responseCount = responseCount
        self.score = score
    }
    
    public func toComment() -> Comment {
        .init(id: id, parentId: parentId, postId: postId, userId: userId, creationDate: creationDate, content: content, upVoteCount: upVoteCount, downVoteCount: downVoteCount, responseCount: responseCount, score: score)
    }
}

public extension Comment {
    func toObservableComment() -> ObservableComment {
        .init(id: id, parentId: parentId, postId: postId, userId: userId, creationDate: creationDate, content: content, upVoteCount: upVoteCount, downVoteCount: downVoteCount, responseCount: responseCount, score: score)
    }
}
