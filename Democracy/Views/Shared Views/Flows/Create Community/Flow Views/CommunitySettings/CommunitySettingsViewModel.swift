//
//  CommunitySettingsViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/30/24.
//

import DemocracySwiftUI
import Foundation
import SharedResourcesClientAndServer

@MainActor @Observable
final class CommunitySettingsViewModel: InputFlowViewModel {
    let flowCoordinator: CommunityInputFlowViewModel
    let skipAction: SkipAction = .nonSkippable
    let nextButtonEnabled: Bool = true
    var settings = CommunitySettings()
    
    init(flowCoordinator: CommunityInputFlowViewModel) {
        self.flowCoordinator = flowCoordinator
    }
    
    func nextButtonAction() async {
        flowCoordinator.input.setSettings(settings)
        flowCoordinator.next()
    }
    
    func setUserInput() {
        settings = flowCoordinator.input.settings
    }
}
