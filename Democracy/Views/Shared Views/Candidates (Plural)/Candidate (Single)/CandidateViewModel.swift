//
//  CandidateViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/20/23.
//

import Foundation
import SharedResourcesClientAndServer

protocol CandidateViewModelProtocol: ObservableObject {
    var candidate: Candidate { get }
}

@MainActor
final class CandidateViewModel: CandidateViewModelProtocol {
    
    let candidate: Candidate
    private weak var coordinator: CommunitiesCoordinatorDelegate?
    
    lazy var candidateBadges: [CandidateBadge] = {
        candidate.badges
    }()
    
    lazy var memberSinceDate: String = {
        Date.now.formatted(date: .long, time: .omitted)
    }()
    
    lazy var candidatePosts: [PostCardViewModel] = {
        Post.previewArray.map { $0.toViewModel(coordinator: self.coordinator) }
    }()
    
    init(coordinator: CommunitiesCoordinatorDelegate,
         candidate: Candidate
    ) {
        self.coordinator = coordinator
        self.candidate = candidate
    }
}

extension Post {
    // TODO: Remove
    @MainActor
    func toViewModel(coordinator: CommunitiesCoordinatorDelegate?) -> PostCardViewModel {
        .init(coordinator: coordinator, post: self)
    }
}
