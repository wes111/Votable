//
//  VotingTabMainView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/23.
//

import SwiftUI

struct VotingTabMainView: View {
    
    @State private var viewModel = VotingTabMainViewModel()
    
    init() {}
    
    var body: some View {
        Text("Voting")
    }
}

// MARK: - Preview
#Preview {
    VotingTabMainView()
}
