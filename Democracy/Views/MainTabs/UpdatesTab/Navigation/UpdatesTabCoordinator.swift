//
//  UpdatesTabCoordinator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/23.
//

import Navigator
import SharedSwiftUI
import SwiftUI

struct UpdatesTabCoordinator: View {
    
    var body: some View {
        ManagedNavigationStack {
            UpdatesTabMainView()
                .navigationDestination(UpdatesDestination.self)
        }
    }
}

// MARK: - Preview
#Preview {
    UpdatesTabCoordinator()
}
