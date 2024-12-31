//
//  PostService.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/3/24.
//

import Factory
import Foundation
import SharedResourcesClientAndServer

@StorageActor
protocol PostService: Sendable {
    func createPost(from userInput: PostCreationRequestBuilder) async throws -> Post
    func fetchPostsForCommunity(communityId: String, filters: PostFilters, paginationOption: CursorPaginationOption) async throws -> [Post]
    
    nonisolated init()
}

struct PostServiceDefault: PostService {
    @Injected(\.postBackendDataService) private var postBackendDataService
    @Injected(\.userAsyncStreamManager) private var userStreamManager
    
    func createPost(from userInput: PostCreationRequestBuilder) async throws -> SharedResourcesClientAndServer.Post {
        let creationRequest = try await userInput.build()
        return try await postBackendDataService.createObject(request: creationRequest)
    }
    
    func fetchPostsForCommunity(communityId: String, filters: PostFilters, paginationOption: CursorPaginationOption) async throws -> [Post] {
        var queries: [AppwriteQuery] = [
            .equal(key: PostAttribute.communityId.key, value: communityId),
            .limit(25),
            .greaterThanEqual(key: PostAttribute.approvedDate.key, date: filters.earliestDate)
        ]
        
        switch paginationOption {
        case .before(let id):
            queries.append(.cursorBefore(id: id))
        case .after(let id):
            queries.append(.cursorAfter(id: id))
        case .initial:
            break
        }
        
        switch filters.approved {
        case .approved:
            queries.append(.isNotNull(key: PostAttribute.approvedDate.key))
        case .notApproved:
            queries.append(.isNull(key: PostAttribute.approvedDate.key))
        case .noFilter:
            break
        }
        
        switch filters.archived {
        case .archived:
            queries.append(.isNotNull(key: PostAttribute.archivedDate.key))
        case .notArchived:
            queries.append(.isNull(key: PostAttribute.archivedDate.key))
        case .noFilter:
            break
        }
        
        if let filterCategory = filters.categoriesFilter {
            queries.append(.equal(key: PostAttribute.categoryName.key, value: filterCategory.name))
        }
        
        switch filters.sortOrder {
        case .newest:
            queries.append(.orderAscending(key: PostAttribute.approvedDate.key))
        case .oldest:
            queries.append(.orderDescending(key: PostAttribute.approvedDate.key))
        case .topRated:
            queries.append(.orderAscending(key: PostAttribute.score.key))
        case .lowRated:
            queries.append(.orderDescending(key: PostAttribute.score.key))
        }
        
        if !filters.tagsFilter.isEmpty {
            queries.append(.contains(
                key: PostAttribute.communityTagsString.key,
                values: filters.tagsFilter.map { $0.name + ", " })
            )
        }
        
        return try await postBackendDataService.fetch(queries: queries)
    }
}
