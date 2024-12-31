//
//  ObservablePost.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/23/24.
//

import Foundation
import SharedResourcesClientAndServer

@Observable
final class ObservablePost: Identifiable, Hashable, Votable {
    let id: String
    let title: String
    let body: String
    let link: URL?
    let categoryName: String
    let tags: [CommunityTag]
    let userId: String
    let communityId: String
    let creationDate: Date
    let approvedDate: Date?
    let archivedDate: Date?
    var upVoteCount: Int
    var downVoteCount: Int
    var commentCount: Int
    var userVote: PostVote?
    var score: Int
    
    init(
        id: String,
        title: String,
        body: String,
        link: URL?,
        categoryName: String,
        tags: [CommunityTag],
        userId: String,
        communityId: String,
        creationDate: Date,
        approvedDate: Date?,
        archivedDate: Date?,
        upVoteCount: Int,
        downVoteCount: Int,
        commentCount: Int,
        score: Int
    ) {
        self.id = id
        self.title = title
        self.body = body
        self.link = link
        self.categoryName = categoryName
        self.tags = tags
        self.userId = userId
        self.communityId = communityId
        self.creationDate = creationDate
        self.approvedDate = approvedDate
        self.archivedDate = archivedDate
        self.upVoteCount = upVoteCount
        self.downVoteCount = downVoteCount
        self.commentCount = commentCount
        self.score = score
    }
    
    func toPost() -> Post {
        .init(id: id, title: title, body: body, link: link, categoryName: categoryName, tags: tags, userId: userId, communityId: communityId, creationDate: creationDate, approvedDate: approvedDate, archivedDate: archivedDate, upVoteCount: upVoteCount, downVoteCount: downVoteCount, commentCount: commentCount, score: score)
    }
}

extension Post {
    func toObservablePost() -> ObservablePost {
        .init(id: id, title: title, body: body, link: link, categoryName: categoryName, tags: tags, userId: userId, communityId: communityId, creationDate: creationDate, approvedDate: approvedDate, archivedDate: archivedDate, upVoteCount: upVoteCount, downVoteCount: downVoteCount, commentCount: commentCount, score: score)
    }
}
