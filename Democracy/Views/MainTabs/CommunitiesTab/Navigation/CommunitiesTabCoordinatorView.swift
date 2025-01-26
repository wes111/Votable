//
//  CommunitiesTabCoordinator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/23.
//

import Navigator
import SwiftUI

struct CommunitiesTabCoordinatorView: View {
    var body: some View {
        ManagedNavigationStack {
            CommunitiesTabMainView()
                .navigationDestination(CommunityDestination.self)
        }
    }
}

// MARK: - Preview
#Preview {
    CommunitiesTabCoordinatorView()
}
