//
//  PostTagsViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/30/24.
//

import DemocracySwiftUI
import Factory
import Foundation
import SharedResourcesClientAndServer

@MainActor @Observable
final class PostTagsViewModel: InputFlowViewModel {
    @ObservationIgnored @Injected(\.postService) private var postService
    let flowCoordinator: PostInputFlowViewModel
    let skipAction: SkipAction = .nonSkippable
    var selectedTags: [CommunityTag] = []
    
    init(flowCoordinator: PostInputFlowViewModel) {
        self.flowCoordinator = flowCoordinator
    }
    
    var nextButtonEnabled: Bool {
        !selectedTags.isEmpty
    }
    
    func nextButtonAction() async {
        flowCoordinator.input.setTags(selectedTags)
        do {
            _ = try await postService.createPost(from: flowCoordinator.input)
            flowCoordinator.next()
        } catch {
            flowCoordinator.handleError(.defaultError)
        }
    }
    
    func setUserInput() {
        selectedTags = flowCoordinator.input.tags
    }
    
    var communityTags: [CommunityTag] {
        flowCoordinator.input.community.tags
    }
    
    func toggleTag(_ tag: CommunityTag) {
        if selectedTags.contains(tag) {
            selectedTags.removeAll(where: { $0 == tag })
        } else {
            selectedTags.append(tag)
        }
    }
}
