//
//  SubmitPostCoordinatorView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import Navigator
import SwiftUI
import SharedResourcesClientAndServer
import SharedSwiftUI

struct CreatePostCoordinatorView: View {
    private let community: Community
    
    init(community: Community) {
        self.community = community
    }
   
    var body: some View {
        ManagedNavigationStack {
            PostInputFlowView(community: community)
                .navigationDestination(CreatePostDestination.self)
        }
    }
}

// MARK: - Preview
#Preview {
    CreatePostCoordinatorView(community: .preview)
}
