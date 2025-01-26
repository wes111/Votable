//
//  VotingTabCoordinator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/23.
//

import Navigator
import SwiftUI

struct VotingTabCoordinator: View {
    
    var body: some View {
        ManagedNavigationStack {
            VotingTabMainView()
                .navigationDestination(VotingTabDestination.self)
        }
    }
}

// MARK: - Preview
#Preview {
    VotingTabCoordinator()
}
