//
//  CommunityInputFlowViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/10/24.
//

import DemocracySwiftUI
import Factory
import Foundation
import SharedResourcesClientAndServer
import SharedSwiftUI

// The InputFlowViewModel for creating new Community objects.
@MainActor @Observable
final class CommunityInputFlowViewModel: InputFlowCoordinatorViewModel {
    var flowPath: CommunityFlow
    var alertModel: NewAlertModel?
    var isShowingProgress: Bool = false
    let input: CommunityCreationRequestBuilder
    private weak var coordinator: SubmitCommunityCoordinator?
    
    init(
        coordinator: SubmitCommunityCoordinator?,
        flowPath: CommunityFlow = .name,
        input: CommunityCreationRequestBuilder = .init()
    ) {
        self.coordinator = coordinator
        self.flowPath = flowPath
        self.input = input
    }
}

// MARK: - Methods
extension CommunityInputFlowViewModel {
    
    func didCompleteFlowSuccessfully() {
        guard let name = input.name?.value else {
            return handleError(.itemMissing(.name))
        }
        coordinator?.goToSuccess(communityName: name)
    }

    func close() {
        coordinator?.close()
    }
}
