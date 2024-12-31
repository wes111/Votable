//
//  PostCardViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/8/23.
//

import Factory
import Foundation
import SharedResourcesClientAndServer

@MainActor @Observable
final class PostCardViewModel: Hashable {
    @ObservationIgnored @Injected(\.voteService) private var voteService
    var linkProviderViewModel: LinkProviderViewModel?
    private weak var coordinator: CommunitiesCoordinatorDelegate?
    let post: ObservablePost
    
    init(coordinator: CommunitiesCoordinatorDelegate?, post: Post) {
        self.coordinator = coordinator
        self.post = post.toObservablePost()
        
        if let url = post.link {
            linkProviderViewModel = LinkProviderViewModel(url)
        }
    }
}

// MARK: - Computed Properites
extension PostCardViewModel {
    var date: String {
        post.creationDate.getFormattedDate(format: .ddMMMyyyy)
    }
    
    var upVoteCount: Int {
        post.upVoteCount
    }
    
    var downVoteCount: Int {
        post.downVoteCount
    }
    
    var userTagline: String {
        "Todo: New York State"
    }
    
    var username: String {
        post.userId
    }
    
    var commentsText: String {
        "\(post.commentCount) comments"
    }
}

// MARK: - Methods
extension PostCardViewModel {
    
    func goToPostView() {
        coordinator?.goToPostView(post.toPost())
    }
    
    func onTapVoteButton(_ vote: VoteType) {
        Task {
            do {
                // TODO: Part of this functionality needs to run on main actor, and part needs to run on storage actor...
                _ = try await voteService.voteOnObject(post, vote: vote)
            } catch {
                print(error)
                print()
            }
        }
    }
    
    func onTapMenuButton() {
        // TODO: ...
    }
}
