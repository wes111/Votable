//
//  PostService+Preview.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/20/24.
//

import Foundation
import SharedResourcesClientAndServer

struct PostServiceMock: PostService {
    func createPost(from userInput: PostCreationRequestBuilder) async throws -> Post {
        .preview
    }
    
    func fetchPostsForCommunity(communityId: String, filters: PostFilters, paginationOption: CursorPaginationOption) async throws -> [Post] {
        Post.previewArray
    }
}
