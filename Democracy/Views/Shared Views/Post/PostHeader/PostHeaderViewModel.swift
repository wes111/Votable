//
//  PostHeaderViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 6/28/24.
//

import DemocracySwiftUI
import Foundation
import SharedResourcesClientAndServer
import SharedSwift
import SharedSwiftUI

@MainActor @Observable
final class PostHeaderViewModel {
    let post: ObservablePost
    var linkProviderViewModel: LinkProviderViewModel?
    
    init(post: Post) {
        self.post = post.toObservablePost()
        
        if let url = post.link {
            linkProviderViewModel = LinkProviderViewModel(url)
        }
    }
}

// MARK: - Computed Properties
extension PostHeaderViewModel {
    var date: String {
        post.creationDate.getFormattedDate(format: .ddMMMyyyy)
    }
    
    var upVoteCount: Int {
        post.upVoteCount
    }
    
    var downVoteCount: Int {
        post.downVoteCount
    }
    
    var commentsText: String {
        "\(post.commentCount) comments"
    }
    
    var selectableCommunityTags: [SelectableCommunityTag] {
        post.tags.map { SelectableCommunityTag(communityTag: $0) }
    }
}

// MARK: - Methods
extension PostHeaderViewModel {
    func onTapShareButton() {
        
    }
    
    func onTapVoteButton(_ vote: VoteType) {
//        Task {
//            do {
//                _ = try await voteService.voteOnObject(post, vote: vote)
//            } catch {
//                print(error)
//                print()
//            }
//        }
    }
}
