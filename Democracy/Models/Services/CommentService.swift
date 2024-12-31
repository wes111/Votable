//
//  CommentService.swift
//  Democracy
//
//  Created by Wesley Luntsford on 5/12/24.
//

import Factory
import Foundation
import SharedResourcesClientAndServer

@StorageActor
protocol CommentService: Sendable {
    func submitComment(parentId: String?, postId: String, content: String) async throws -> Comment
    func fetchComments(request: CommentFetchRequest) async throws -> [Comment] 
    
    nonisolated init()
}

struct CommentServiceDefault: CommentService {
    @Injected(\.commentBackendDataService) private var commentBackendDataService
    @Injected(\.userAsyncStreamManager) private var userStreamManager
    
    func submitComment(parentId: String?, postId: String, content: String) async throws -> Comment {
        guard let user = userStreamManager.currentValue else {
            throw GenericError.missingUser
        }
        
        return try await commentBackendDataService.createObject(request: CommentCreationRequest(
            parentId: parentId,
            postId: postId,
            userId: user.id,
            content: content
        ))
    }
    
    func fetchComments(request: CommentFetchRequest) async throws -> [Comment] {
        var queries: [AppwriteQuery] = [
            .limit(25)
        ]
        
        switch request {
        case .initialRootComments(let postId):
            queries.append(.equal(key: CommentAttribute.postId.key, value: postId))
            queries.append(.isNull(key: CommentAttribute.parentId.key))
            
        case .rootComments(let postId, let afterCommentId):
            queries.append(.equal(key: CommentAttribute.postId.key, value: postId))
            queries.append(.cursorAfter(id: afterCommentId))
            queries.append(.isNull(key: CommentAttribute.parentId.key))
            
        case .initialChildComments(let parentId):
            queries.append(.equal(key: CommentAttribute.parentId.key, value: parentId))
            
        case .childComments(let parentId, let afterCommentId):
            queries.append(.equal(key: CommentAttribute.parentId.key, value: parentId))
            queries.append(.cursorAfter(id: afterCommentId))
        }
        
        return try await commentBackendDataService.fetch(queries: queries)
    }
}
