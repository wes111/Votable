//
//  ObservableComment.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/23/24.
//

import Foundation
import SharedResourcesClientAndServer

@Observable
final class ObservableComment: Identifiable, Hashable, Votable {
    let id: String
    let parentId: String?
    let postId: String
    let userId: String
    let creationDate: Date
    let content: String
    var upVoteCount: Int
    var downVoteCount: Int
    var score: Int
    let responseCount: Int
    var userVote: CommentVote?
    
    init(
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
    
    func toComment() -> Comment {
        .init(id: id, parentId: parentId, postId: postId, userId: userId, creationDate: creationDate, content: content, upVoteCount: upVoteCount, downVoteCount: downVoteCount, responseCount: responseCount, score: score)
    }
}

extension Comment {
    func toObservableComment() -> ObservableComment {
        .init(id: id, parentId: parentId, postId: postId, userId: userId, creationDate: creationDate, content: content, upVoteCount: upVoteCount, downVoteCount: downVoteCount, responseCount: responseCount, score: score)
    }
}
