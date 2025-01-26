//
//  MainTabCoordinator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/19/23.
//

import SharedSwiftUI
import SwiftUI

enum MainTab {
    case voting, events, updates, communities, history
}

@MainActor
final class MainTabViewModel: ObservableObject {
    @Published var selectedTab: MainTab = .updates
}

struct MainTabView: View {
    @StateObject private var viewModel: MainTabViewModel
    private let theme: Theme
    
    init(viewModel: MainTabViewModel, theme: Theme) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.theme = theme
        
        // TODO: Below has been moved to ToolBarNavigationModifier, but the same logic is needed
        // for the bottom bar. Move out of this view and abstract away...
        UITabBar.appearance().unselectedItemTintColor = UIColor(theme.primaryColorScheme.tertiaryBackground)
        
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
    
    var body: some View {
        TabView(selection: $viewModel.selectedTab) {
            VotingTabCoordinator()
                .tabItem {
                    Label("Voting", systemImage: "checklist")
                        .foregroundColor(theme.primaryColorScheme.primaryText)
                }
                .tag(MainTab.voting)
            
            EventsTabCoordinator()
                .tabItem {
                    Label("Events", systemImage: "calendar")
                }
                .tag(MainTab.events)
            
            UpdatesTabCoordinator()
                .tabItem {
                    Label("Updates", systemImage: "newspaper.fill")
                }
                .tag(MainTab.updates)
            
            CommunitiesTabCoordinatorView()
                .tabItem {
                    Label("Communities", systemImage: "person.3.fill")
                }
                .tag(MainTab.communities)
            
            HistoryTabCoordinator()
                .tabItem {
                    Label("History", systemImage: "books.vertical.fill")
                }
                .tag(MainTab.history)
        }
        .navigationBarBackButtonHidden()
        .accentColor(theme.primaryColorScheme.secondaryText)
    }
    
}

// MARK: - Preview
#Preview {
    let viewModel = MainTabViewModel()
    MainTabView(viewModel: viewModel, theme: Theme.defaultTheme)
}
