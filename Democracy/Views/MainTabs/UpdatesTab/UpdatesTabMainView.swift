//
//  UpdatesTabMainView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/23.
//

import SwiftUI

struct UpdatesTabMainView<ViewModel: UpdatesTabMainViewModelProtocol>: View {
    
    @StateObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        AsyncButton(
            action: { await viewModel.logout() },
            label: { Text("Updates. Logout") },
            showProgressView: $viewModel.isShowingProgress
        )
    }
}

// MARK: - Preview
#Preview {
    UpdatesTabMainView(viewModel: UpdatesTabMainViewModel.preview)
}
