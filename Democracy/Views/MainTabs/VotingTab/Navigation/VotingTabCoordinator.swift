//
//  VotingTabCoordinator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/23.
//

import SwiftUI

struct VotingTabCoordinator: View {
    
    @State private var viewModel: VotingTabCoordinatorViewModel
    
    init(viewModel: VotingTabCoordinatorViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        CoordinatorView(router: viewModel.router) {
            VotingTabMainView(viewModel: viewModel.votingTabMainViewModel())
        } secondaryScreen: { (path: VotingTabPath) in
            createViewFromPath(path)
        }
    }
    
    @ViewBuilder
    func createViewFromPath(_ path: VotingTabPath) -> some View {
        switch path {
        case .one: EmptyView()
        }
    }
}

// extension VotingTabCoordinator: VotingTabMainCoordinatorDelegate {
//
//    func tappedNav() {
//        print("tapped nav")
//    }
//    
// }

// MARK: - Preview
#Preview {
    let viewModel = VotingTabCoordinatorViewModel()
    return VotingTabCoordinator(viewModel: viewModel)
}
