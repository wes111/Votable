//
//  AcceptTermsView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/6/23.
//

import SharedSwiftUI
import SwiftUI

@MainActor
struct AccountAcceptTermsView: View {
    @State var viewModel: AccountAcceptTermsViewModel
    @Environment(\.theme) var theme: Theme
    
    var body: some View {
        primaryContent
            .onAppear {
                viewModel.setUserInput()
            }
    }
}

// MARK: - Subviews
extension AccountAcceptTermsView {
    
    var primaryContent: some View {
        ZStack {
            theme.primaryColorScheme.primaryBackground.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 20) {
                Spacer()
                agreeButton
            }
            .padding()
        }
    }
    
    var agreeButton: some View {
        AsyncButton(showProgressView: $viewModel.isShowingProgress) {
            await viewModel.nextButtonAction()
        } label: {
            Text("I agree")
        }
        .buttonStyle(PrimaryButtonStyle())
    }
}

// MARK: - Preview
#Preview {
    AccountAcceptTermsView(viewModel: .preview)
}
