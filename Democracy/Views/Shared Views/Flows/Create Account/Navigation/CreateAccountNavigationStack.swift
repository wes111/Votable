//
//  OnboardingCoordinator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 9/30/23.
//

import Navigator
import SharedSwiftUI
import SwiftUI

struct CreateAccountNavigationStack: View {
    var body: some View {
        ManagedNavigationStack {
            AccountInputFlowView()
                .navigationDestination(CreateAccountDestination.self)
        }
    }
}

// MARK: - Preview
#Preview {
    CreateAccountNavigationStack()
}
