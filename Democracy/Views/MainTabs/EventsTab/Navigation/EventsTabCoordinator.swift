//
//  EventsTabCoordinator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/23.
//

import Navigator
import SharedSwiftUI
import SwiftUI

struct EventsTabCoordinator: View {
    
    var body: some View {
        ManagedNavigationStack {
            EventsTabMainView()
                .navigationDestination(EventsTabDestination.self)
        }
    }
}

// MARK: - Preview
#Preview {
    EventsTabCoordinator()
}
