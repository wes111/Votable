//
//  UpdatesTabMainView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/23.
//

import SharedSwiftUI
import SwiftUI

struct UpdatesTabMainView: View {
    
    @State private var viewModel: UpdatesTabMainViewModel = .init()
    
    var body: some View {
        AsyncButton(showProgressView: $viewModel.isShowingProgress) {
            await viewModel.logout()
        } label: {
            Text("Updates. Logout")
        }
    }
}

// MARK: - Preview
#Preview {
    UpdatesTabMainView()
}
