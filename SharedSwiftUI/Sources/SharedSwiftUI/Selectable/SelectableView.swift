//
//  SelectableCategory.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/4/24.
//

import SwiftUI

struct SelectableView: View {
    @Environment(\.theme) var theme: Theme
    var isSelected: Bool
    let title: String
    let subtitle: String?
    let image: SystemImage?
    
    private let isSmall: Bool
    
    init(
        isSelected: Bool,
        title: String,
        subtitle: String? = nil,
        image: SystemImage? = nil
    ) {
        self.isSelected = isSelected
        self.title = title
        self.subtitle = subtitle
        self.image = image
        
        isSmall = subtitle == nil
    }
    
    var body: some View {
        HStack(alignment: .center) {
            if let image {
                Image(systemName: image.rawValue)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 25)
                    .font(.system(.title3, weight: .semibold))
                    .foregroundStyle(theme.primaryColorScheme.secondaryText)
            }
            
            VStack(alignment: .leading, spacing: 0) {
                Text(title)
                    .font(isSmall ? .footnote : .body)
                    .fontWeight(.semibold)
                    .foregroundStyle(theme.primaryColorScheme.secondaryText)
                
                if let subtitle {
                    Text(subtitle)
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundStyle(theme.primaryColorScheme.secondaryText.opacity(0.5))
                }
            }
            
            Spacer()
            
            Image(systemName: SystemImage.checkmarkCircleFill.rawValue)
                .font(isSmall ? .footnote : .body)
                .opacity(isSelected ? 1.0 : 0.0)
                .foregroundStyle(Color.green)
                
        }
        .padding(theme.sizeConstants.innerBorder)
        .background(
            theme.primaryColorScheme.secondaryBackground,
            in: RoundedRectangle(cornerRadius: theme.sizeConstants.cornerRadius)
        )
        .overlay(
            RoundedRectangle(cornerRadius: theme.sizeConstants.cornerRadius)
                .strokeBorder(
                    isSelected ? theme.primaryColorScheme.tertiaryText : .clear,
                    lineWidth: isSmall ? theme.sizeConstants.thinBorderWidth : theme.sizeConstants.borderWidth
                )
        )
    }
}

// MARK: - Preview
#Preview {
    @Previewable @Environment(\.theme) var theme: Theme
    ZStack {
        theme.primaryColorScheme.primaryBackground.ignoresSafeArea()
        
        VStack(spacing: theme.sizeConstants.elementSpacing) {
            SelectableView(isSelected: false, title: "Selectable Category")
            
            SelectableView(
                isSelected: true,
                title: "Selectable Category",
                subtitle: "Subtitle",
                image: .exclamationmarkTriangle
            )
            
            SelectableView(
                isSelected: true,
                title: "Selectable Category",
                image: nil
            )
        }
        .padding()
    }
}
