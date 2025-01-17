//
//  CoordinatorView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 8/7/23.
//

import SwiftUI

public struct CoordinatorView<Path: Hashable, RootView: View, PushedView: View>: View {
    
    @Bindable var router: Router
    private let mainScreen: RootView
    private let secondaryScreen: (_ path: Path) -> PushedView
    
    public init(router: Router,
         @ViewBuilder mainScreen: () -> RootView,
         @ViewBuilder secondaryScreen: @escaping (_ path: Path) -> PushedView
    ) {
        self.router = router
        self.mainScreen = mainScreen()
        self.secondaryScreen = secondaryScreen
    }
    
    public var body: some View {
        NavigationStack(path: $router.navigationPath) {
            mainScreen
                .navigationDestination(for: Path.self) { path in
                    secondaryScreen(path)
                }
        }
    }
}

// MARK: - Preview
#Preview {
    CoordinatorView(router: .init()) {
        Text("Hello")
    } secondaryScreen: { (_: MockSelectable) in
        Text("World")
    }
}
