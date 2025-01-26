//
//  HistoryTabCoordinator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/23.
//

import Navigator
import SwiftUI

struct HistoryTabCoordinator: View {
    
    var body: some View {
        ManagedNavigationStack {
            HistoryTabMainView()
                .navigationDestination(HistoryTabDestination.self)
        }
    }
}

// MARK: - Preview
#Preview {
    HistoryTabCoordinator()
}
