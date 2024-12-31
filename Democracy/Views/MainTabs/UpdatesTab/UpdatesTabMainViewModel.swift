//
//  UpdatesTabMainViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/23.
//

import Factory
import Foundation

@MainActor
protocol UpdatesTabMainCoordinatorDelegate: AnyObject {
    func tappedNav()
}

@MainActor
protocol UpdatesTabMainViewModelProtocol: ObservableObject {
    func tappedNav()
    func logout() async
    var isShowingProgress: Bool { get set }
}

final class UpdatesTabMainViewModel: UpdatesTabMainViewModelProtocol {
    
    @Injected(\.sessionService) private var sessionService
    @Injected(\.sessionAsyncStreamManager) private var sessionStreamManager
    @Published var isShowingProgress = false
    
    @StorageActor
    func logout() async {
        do {
            guard let session = await sessionStreamManager.currentValue else {
                throw GenericError.defaultError
            }
            try await sessionService.logout(sessionId: session.id)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // private weak var coordinator: UpdatesTabMainCoordinatorDelegate?
    
    init() {
        // self.coordinator = coordinator
    }
    
    func tappedNav() {
        // coordinator?.tappedNav()
    }
}
