//
//  ToolbarNavigationModifier.swift
//  SharedSwiftUI
//
//  Created by Wesley Luntsford on 12/29/24.
//

import SwiftUI

@MainActor
public struct ToolbarNavigationModifier: ViewModifier {
    @Environment(\.theme) var theme: Theme
    let leadingContent: [TopBarContent]
    let centerContent: [TopBarContent]
    let trailingContent: [TopBarContent]
    
    public init(
        leadingContent: [TopBarContent],
        centerContent: [TopBarContent],
        trailingContent: [TopBarContent]
    ) {
        self.leadingContent = leadingContent
        self.centerContent = centerContent
        self.trailingContent = trailingContent
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(theme.primaryColorScheme.primaryText)
        ]
        navigationBarAppearance.backgroundColor = UIColor(theme.primaryColorScheme.primaryBackground)
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        UINavigationBar.appearance().clipsToBounds = true
        
        let tabBarApperance = UITabBarAppearance()
        tabBarApperance.configureWithOpaqueBackground()
        tabBarApperance.backgroundColor = UIColor(theme.primaryColorScheme.primaryBackground)
        UITabBar.appearance().scrollEdgeAppearance = tabBarApperance
        UITabBar.appearance().standardAppearance = tabBarApperance
    }
    
    public func body(content: Content) -> some View {
        content
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                toolBarContent(content: leadingContent, placement: .topBarLeading)
                toolBarContent(content: centerContent, placement: .principal)
                toolBarContent(content: trailingContent, placement: .topBarTrailing)
            }
    }
}

// MARK: - Subviews
private extension ToolbarNavigationModifier {
    
    func toolBarContent(content: [TopBarContent], placement: ToolbarItemPlacement) -> some ToolbarContent {
        ToolbarItemGroup(placement: placement) {
            ForEach(content) { item in
                switch item {
                case .back(let action):
                    backButton(action: action)
                    
                case .title(let title, let size):
                    switch size {
                    case .small:
                        Text(title)
                            .font(.headline)
                            .foregroundColor(theme.primaryColorScheme.primaryText)
                        
                    case .medium:
                        Text(title)
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(theme.primaryColorScheme.primaryText)
                        
                    case .large:
                        Text(title)
                            .standardScreenTitle()
                    }
                    
                case .close(let action):
                    closeButton(action: action)
                    
                case .search(let action):
                    searchButton(action: action)
                    
                case .menu(let options):
                    menuButton(options)
                    
                case .filter(let action):
                    filterButton(action: action)
                }
            }
        }
    }
}

// MARK: Buttons
private extension ToolbarNavigationModifier {
    func backButton(action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            Image(systemName: SystemImage.chevronLeft.rawValue)
                .foregroundColor(theme.primaryColorScheme.tertiaryText)
        }
    }
    
    func closeButton(action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            Image(systemName: SystemImage.xMark.rawValue)
                .foregroundColor(theme.primaryColorScheme.tertiaryText)
        }
    }
    
    func searchButton(action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            Image(systemName: SystemImage.magnifyingGlass.rawValue)
                .foregroundColor(theme.primaryColorScheme.tertiaryText)
        }
    }
    
    func filterButton(action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            Image(systemName: SystemImage.slideVerticalThree.rawValue)
        }
    }
    
    func menuButton(_ options: [MenuButtonOption]) -> some View {
        Menu {
            ForEach(options) { option in
                Button(option.title) { option.action() }
            }
        } label: {
            Image(systemName: SystemImage.ellipsis.rawValue)
                .foregroundColor(theme.primaryColorScheme.tertiaryText)
        }
    }
}

// MARK: View extension
@MainActor
public extension View {
    func toolbarNavigation(
        leadingContent: [TopBarContent] = [],
        centerContent: [TopBarContent] = [],
        trailingContent: [TopBarContent] = []
    ) -> some View {
        modifier(ToolbarNavigationModifier(
            leadingContent: leadingContent,
            centerContent: centerContent,
            trailingContent: trailingContent
        ))
    }
}
