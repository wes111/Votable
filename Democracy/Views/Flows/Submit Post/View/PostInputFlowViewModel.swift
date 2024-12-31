//
//  PostInputFlowViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/9/24.
//

import Factory
import Foundation
import SharedResourcesClientAndServer

// The InputFlowViewModel for creating new Post objects.
@MainActor @Observable
final class PostInputFlowViewModel: InputFlowCoordinatorViewModel {
    @ObservationIgnored @Injected(\.postService) private var postService
    var flowPath: PostFlow
    var alertModel: NewAlertModel?
    var isShowingProgress: Bool = false
    let input: PostCreationRequestBuilder
    private weak var coordinator: SubmitPostCoordinator?
    
    init(coordinator: SubmitPostCoordinator?, community: Community, flowPath: PostFlow = .title) {
        self.coordinator = coordinator
        self.input = .init(community: community)
        self.flowPath = flowPath
    }
    
    func didCompleteFlowSuccessfully() {
        coordinator?.goToSuccess()
    }
    
    func close() {
        coordinator?.close()
    }
}
