//
//  RuleView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/27/24.
//

import SharedSwiftUI
import SwiftUI

struct MenuCard<MenuContent: View>: View {
    @ViewBuilder let menuContent: MenuContent
    let title: String
    let description: String?
    
    init(
        title: String,
        description: String?,
        @ViewBuilder menuContent: () -> MenuContent
    ) {
        self.title = title
        self.description = description
        self.menuContent = menuContent()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: ViewConstants.elementSpacing) {
            HStack(alignment: .firstTextBaseline, spacing: 0) {
                formattedTitle
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                menuButton
            }
            
            formattedDescription
        }
        .padding(ViewConstants.innerBorder)
        .frame(height: 175, alignment: .top)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.onBackground, in: RoundedRectangle(cornerRadius: ViewConstants.cornerRadius))
        .foregroundStyle(Color.secondaryText)
    }
    
    var menuButton: some View {
        Menu {
            menuContent
        } label: {
            Image(systemName: SystemImage.ellipsis.rawValue)
                .font(.footnote)
                .foregroundStyle(Color.secondaryText)
                .padding(10)
                .background(
                    Circle()
                        .fill(Color.tertiaryBackground)
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
            .foregroundStyle(Color.tertiaryText)
    }
}

// MARK: - Preview
#Preview {
    ZStack {
        Color.primaryBackground.ignoresSafeArea()
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
