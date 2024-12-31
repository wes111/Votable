//
//  SelectablePickerView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/24/24.
//

import SwiftUI

@MainActor
struct TappableListItem: View {
    @Environment(\.theme) var theme: Theme
    @ScaledMetric(relativeTo: .title3) var imageSize = 25.0
    let title: String
    let subtitle: String
    let image: SystemImage?
    let tapAction: () -> Void
    
    init(title: String, subtitle: String, image: SystemImage? = nil, tapAction: @escaping () -> Void) {
        self.title = title
        self.subtitle = subtitle
        self.image = image
        self.tapAction = tapAction
    }
    
    var body: some View {
        Button {
            tapAction()
        } label: {
            HStack(alignment: .center, spacing: theme.sizeConstants.elementSpacing) {
                if let imageName = image?.rawValue {
                    Image(systemName: imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: imageSize, height: imageSize)
                        .foregroundStyle(theme.primaryColorScheme.secondaryText)
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(title)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .foregroundStyle(theme.primaryColorScheme.secondaryText)
                    
                    Text(subtitle)
                        .font(.footnote)
                        .fontWeight(.medium)
                        .foregroundStyle(theme.primaryColorScheme.secondaryText.opacity(0.5))
                }
                
                Spacer()
                
                Image(systemName: SystemImage.chevronRight.rawValue)
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundStyle(theme.primaryColorScheme.secondaryText.opacity(0.25))
            }
        }
    }
}

// MARK: - Preview
#Preview {
    @Previewable @Environment(\.theme) var theme: Theme
    ZStack {
        theme.primaryColorScheme.primaryBackground.ignoresSafeArea()
        
        TappableListItem(
            title: "Tappable Title",
            subtitle: "Tappable Subtitle",
            image: .arrowRight,
            tapAction: {}
        )
        .padding()
    }
}
