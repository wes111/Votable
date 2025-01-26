//
//  CreateCommunityCoordinatorView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import Navigator
import SharedSwift
import SharedSwiftUI
import SwiftUI

struct CreateCommunityCoordinatorView: View {
    
    var body: some View {
        ManagedNavigationStack {
            CommunityInputFlowView()
                .navigationDestination(CreateCommunityDestination.self)
        }
    }
}

// MARK: - Preview
#Preview {
    CreateCommunityCoordinatorView()
}
