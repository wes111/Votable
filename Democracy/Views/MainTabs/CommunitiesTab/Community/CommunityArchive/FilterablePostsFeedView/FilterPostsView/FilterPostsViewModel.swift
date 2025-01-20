//
//  FilterPostsViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/29/24.
//

import DemocracySwiftUI
import Foundation
import SharedResourcesClientAndServer
import SharedSwiftUI

@MainActor @Observable
final class FilterPostsViewModel {
    let communityTags: [SelectableCommunityTag]
    let onUpdateFilters: (PostFilters) -> Void
    var router = Router()
    var postFilters: PostFilters
    
    init(
        communityTags: [SelectableCommunityTag],
        postFilters: PostFilters,
        onUpdateFilters: @escaping (PostFilters) -> Void
    ) {
        self.postFilters = postFilters
        self.communityTags = communityTags
        self.onUpdateFilters = onUpdateFilters
    }
}

// MARK: - Computed Properties
extension FilterPostsViewModel {
    
    var selectableSortOrder: SelectableSortOrderOption {
        .init(postFilters.sortOrder)
    }
    
    var selectableDateFilter: SelectableDateFilter {
        .init(postFilters.dateFilter)
    }
    
    var categoriesSubtitle: String {
        if postFilters.tagsFilter.isEmpty {
            "None Selected"
        } else {
            postFilters.tagsFilter.map { $0.name }.sorted().joined(separator: ", ")
        }
    }
    
    var selectedTags: [SelectableCommunityTag] {
        postFilters.tagsFilter.map{ SelectableCommunityTag($0) }
    }
}

// MARK: - Methods
extension FilterPostsViewModel  {
    
    func navigateToPath(_ path: FilterPostsPath) {
        router.push(path)
    }
    
    func backAction() {
        router.pop()
    }
    
    func toggleTag(_ tag: SelectableCommunityTag) {
        if postFilters.tagsFilter.map({ SelectableCommunityTag($0) }).contains(tag) {
            postFilters.tagsFilter.removeAll(where: { $0 == tag.communityTag })
        } else {
            postFilters.tagsFilter.append(tag.communityTag)
        }
    }
    
    func onTapUpdateFilters() {
        onUpdateFilters(postFilters)
    }
}
