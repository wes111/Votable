//
//  ContentView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/14/23.
//

import Combine
import SwiftUI

struct ContentView: View {
    var body: some View {
        RootCoordinatorView(viewModel: RootCoordinator())
            .onOpenURL { incomingURL in
                print("App was opened via URL: \(incomingURL)")
            }
    }
}

// MARK: - Preview
#Preview {
    ContentView()
}
