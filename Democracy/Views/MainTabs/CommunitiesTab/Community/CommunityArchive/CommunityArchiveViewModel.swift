//
//  CommunityArchiveViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/10/24.
//

import Foundation
import SharedResourcesClientAndServer

@MainActor @Observable
final class CommunityArchiveViewModel {
    
    let community: Community
    
    init(community: Community) {
        self.community = community
    }
}

// MARK: - Methods
extension CommunityArchiveViewModel {
    func postCountStringForCategory(_ category: PostCategory?) -> String {
        "\(category?.postCount ?? allPostsCount) Posts"
    }
    
    func nameForCategory(_ category: PostCategory?) -> String {
        "\(category?.name ?? "All Categories")"
    }
}

// MARK: - Computed Properties
extension CommunityArchiveViewModel {
    var categories: [PostCategory] {
        community.categories
    }
    
    private var allPostsCount: Int {
        community.categories.reduce(0) { $0 + $1.postCount }
    }
}
