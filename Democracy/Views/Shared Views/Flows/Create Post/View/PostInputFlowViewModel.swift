//
//  PostInputFlowViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/9/24.
//

import Factory
import Foundation
import SharedResourcesClientAndServer
import SharedSwiftUI
import DemocracySwiftUI

// The InputFlowViewModel for creating new Post objects.
@MainActor @Observable
final class PostInputFlowViewModel: InputFlowCoordinatorViewModel {
    @ObservationIgnored @Injected(\.postService) private var postService
    var flowPath: PostFlow
    var alertModel: NewAlertModel?
    var isShowingProgress: Bool = false
    let input: PostCreationRequestBuilder
    var didCompleteSuccessfully: Bool = false
    
    init(community: Community, flowPath: PostFlow) {
        self.input = .init(community: community)
        self.flowPath = flowPath
    }
    
    func didCompleteFlowSuccessfully() {
        didCompleteSuccessfully = true
    }
}
