//
//  CommentService+Preview.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/20/24.
//

import Foundation
import SharedResourcesClientAndServer

struct CommentServiceMock: CommentService {
    func submitComment(parentId: String?, postId: String, content: String) async throws -> Comment {
        .preview
    }
    
    func fetchComments(request: CommentFetchRequest) async throws -> [Comment] {
        []
    }
}
