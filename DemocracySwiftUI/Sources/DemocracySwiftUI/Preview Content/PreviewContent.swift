//
//  PreviewContent.swift
//  DemocracySwiftUI
//
//  Created by Wesley Luntsford on 1/1/25.
//

import Foundation
import SharedSwiftUI

// This should be used for internal previews only. Hence, this is not marked `public`.
@MainActor
final class MockSubmittableViewModel: SubmittableTextEditorInputViewModelProtocol {
    var focusedField: MockUserInputFlow = .mockOne
    var selectedTab = MockSelectable.mockOne
    let flowCoordinator = MockInputFlowCoordinator()
    var text: String = ""
    var skipAction: SkipAction = .nonSkippable
    var nextButtonEnabled: Bool = true
    
    init() {}
    
    public var markdown: String {
        "Hello World"
    }
    
    public func nextButtonAction() async {
        return
    }
    
    public func setUserInput() {
        return
    }
}

// This should be used for internal previews only. Hence, this is not marked `public`.
@MainActor
final class MockInputFlowCoordinator: InputFlowCoordinatorViewModel {
    var flowPath: MockUserInputFlow = .mockOne
    var isShowingProgress: Bool = false
    var alertModel: SharedSwiftUI.NewAlertModel?
    
    init() {}
    
    func didCompleteFlowSuccessfully() {
        return
    }
    
    func close() {
        return
    }
}

enum MockUserInputFlow: Int, UserInputFlow {
    case mockOne
    case mockTwo
    case mockThree
    
    static let flowTitle: String = "Mock Flow Title"
    
    var title: String {
        "Mock Title"
    }
    
    var subtitle: String {
        "Mock Subtitle"
    }
    
    var canGoBack: Bool {
        true
    }
}
