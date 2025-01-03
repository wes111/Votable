//
//  RuleView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/27/24.
//

import SharedSwiftUI
import SwiftUI

public struct MenuCard<MenuContent: View>: View {
    @Environment(\.theme) var theme: Theme
    @ViewBuilder let menuContent: MenuContent
    let title: String
    let description: String?
    
    public init(
        title: String,
        description: String?,
        @ViewBuilder menuContent: () -> MenuContent
    ) {
        self.title = title
        self.description = description
        self.menuContent = menuContent()
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: theme.sizeConstants.elementSpacing) {
            HStack(alignment: .firstTextBaseline, spacing: 0) {
                formattedTitle
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                menuButton
            }
            
            formattedDescription
        }
        .padding(theme.sizeConstants.innerBorder)
        .frame(height: 175, alignment: .top)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(theme.primaryColorScheme.secondaryBackground, in: RoundedRectangle(cornerRadius: theme.sizeConstants.cornerRadius))
        .foregroundStyle(theme.primaryColorScheme.secondaryText)
    }
    
    var menuButton: some View {
        Menu {
            menuContent
        } label: {
            Image(systemName: SystemImage.ellipsis.rawValue)
                .font(.footnote)
                .foregroundStyle(theme.primaryColorScheme.secondaryText)
                .padding(10)
                .background(
                    Circle()
                        .fill(theme.primaryColorScheme.tertiaryBackground)
                )

        }
    }
    
    func formattedImage(_ image: SystemImage) -> some View {
        Image(systemName: image.rawValue)
            .font(.system(.title3))
    }
    
    var formattedTitle: some View {
        Text(title)
            .font(.headline)
    }
    
    var formattedDescription: some View {
        Text(description ?? "")
            .font(.system(.caption))
            .foregroundStyle(theme.primaryColorScheme.tertiaryText)
    }
}

// MARK: - Preview
#Preview {
    @Previewable @Environment(\.theme) var theme: Theme
    
    ZStack {
        theme.primaryColorScheme.primaryBackground.ignoresSafeArea()
        MenuCard(
            title: "Menu Card Title",
            description: "Menu Card Description"
        ) {
            EmptyView()
        }
        .frame(height: 250)
        .padding()
    }
}
