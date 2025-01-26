//
//  UserInputViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/30/23.
//

import SharedSwiftUI
import SwiftUI

@MainActor
public protocol TextInputFlowViewModel: InputFlowViewModel {
    var text: String { get set }
    var focusedField: CoordinatorViewModel.Flow { get }
    var shouldPerformOnSubmit: Bool { get set }
    
    func onSubmit() async // Called when a user taps "enter."
}

public extension TextInputFlowViewModel {
    // Override for custom functionality.
    func onSubmit() async {
        await nextButtonAction()
    }
}

@MainActor
public protocol InputFlowCoordinatorViewModel: Observable, AnyObject {
    associatedtype Flow: UserInputFlow
    
    var flowPath: Flow { get set }
    var totalProgress: Int { get }
    var currentProgress: Int { get }
    var isShowingProgress: Bool { get set }
    var alertModel: NewAlertModel? { get set }
    var viewTitle: String { get }
    var viewSubtitle: String { get }
    var leadingButtons: [TopBarContent] { get }
    //var trailingButtons: [TopBarContent] { get }
    
    func didCompleteFlowSuccessfully()
    //func close()
    func handleError(_ error: CreationRequestBuilderError<Flow>)
}

public extension InputFlowCoordinatorViewModel {
    var currentProgress: Int {
        flowPath.progress
    }
    
    var totalProgress: Int {
        Flow.allCases.count
    }
    
    var viewTitle: String {
        flowPath.title
    }
    
    var viewSubtitle: String {
        flowPath.subtitle
    }
    
//    var trailingButtons: [TopBarContent] {
//        [.close(close)]
//    }
    
    var leadingButtons: [TopBarContent] {
        flowPath.canGoBack ? [.back(back)] : []
    }
    
    func back() {
        if let previous = flowPath.previous {
            flowPath = previous
        }
    }
    
    func next() {
        if let next = flowPath.next {
            flowPath = next
        } else {
            didCompleteFlowSuccessfully()
        }
    }
    
    func handleError(_ error: CreationRequestBuilderError<Flow>) {
        alertModel = error.alert
    }
}


// Individual view models
@MainActor
public protocol InputFlowViewModel: Observable, AnyObject {
    associatedtype CoordinatorViewModel: InputFlowCoordinatorViewModel
    
    var flowCoordinator: CoordinatorViewModel { get }
    var skipAction: SkipAction { get }
    var nextButtonEnabled: Bool { get }
    var isShowingProgress: Bool { get set }
    
    func nextButtonAction() async
    func setUserInput()
}

public extension InputFlowViewModel {
    
    var isShowingProgress: Bool {
        get {
            flowCoordinator.isShowingProgress
        }
        set {
            flowCoordinator.isShowingProgress = newValue
        }
    }
    
    var alertModel: NewAlertModel? {
        get {
            flowCoordinator.alertModel
        }
        set {
            flowCoordinator.alertModel = newValue
        }
    }
}
