//
//  CustomLinkProviderView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 6/27/24.
//

import SwiftUI

@MainActor
public struct CustomLinkProviderView: View {
    @Environment(\.theme) var theme: Theme
    @Environment(\.openURL) var openURL
    @State private var viewModel: LinkProviderViewModel
    @State private var availableImageHeight: CGFloat = 1.0
    @State private var availableWidth: CGFloat = 1.0
    
    public init(viewModel: LinkProviderViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        content
            .task {
                await viewModel.fetchMetadata()
            }
            .background(
                GeometryReader { proxy in
                    let proxyWidth = proxy.size.width
                    Color.clear
                        .task(id: proxy.size.width) {
                            $availableWidth.wrappedValue = max(proxyWidth, 0)
                        }
                }
            )
    }
}

// MARK: - Subviews
private extension CustomLinkProviderView {
    var content: some View {
        Button {
            openURL(viewModel.previewUrl)
        } label: {
            primaryLayout
                .padding(theme.sizeConstants.smallInnerBorder)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    theme.primaryColorScheme.secondaryBackground,
                    in: RoundedRectangle(cornerRadius: theme.sizeConstants.cornerRadius)
                )
        }
        // Hack: We need plain button style here (instead of link) so we can limit the size of the
        // tappable area within a list.
        .buttonStyle(.plain)
    }
    
    var primaryLayout: some View {
        ZStack(alignment: .bottomTrailing) {
            HStack(spacing: theme.sizeConstants.elementSpacing) {
                if let uiImage = viewModel.image {
                    image(uiImage)
                }
                
                VStack(alignment: .leading, spacing: theme.sizeConstants.smallElementSpacing) {
                    if let titleText = viewModel.title {
                        title(titleText)
                    }
                    
                    if let url = viewModel.url {
                        link(url)
                    }
                }
                
                Spacer()
            }
            
            Image(systemName: SystemImage.arrowUpRightSquare.rawValue)
                .foregroundStyle(theme.primaryColorScheme.secondaryText)
        }
    }
    
    func image(_ image: UIImage) -> some View {
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(maxWidth: availableImageHeight, maxHeight: availableWidth / 3)
            .clipped()
            .cornerRadius(theme.sizeConstants.cornerRadius)
            .background(
                GeometryReader { proxy in
                    let proxyHeight = proxy.size.height
                    Color.clear
                        .task(id: proxy.size.height) {
                            $availableImageHeight.wrappedValue = max(proxyHeight, 0)
                            print(max(proxyHeight, 0))
                        }
                }
            )
    }
    
    func title(_ title: String) -> some View {
        Text(title)
            .foregroundStyle(theme.primaryColorScheme.primaryText)
            .font(.footnote)
            .lineLimit(3)
            .multilineTextAlignment(.leading)
            .minimumScaleFactor(theme.sizeConstants.minTextScale)
    }
    
    func link(_ url: String) -> some View {
        Text(url)
            .font(.caption2)
            .foregroundColor(theme.primaryColorScheme.tertiaryText)
            .lineLimit(2)
            .multilineTextAlignment(.leading)
            .minimumScaleFactor(theme.sizeConstants.minTextScale)
    }
}

// MARK: - Preview
#Preview(traits: .standardPreviewModifier) {
    
    VStack(spacing: 25) {
        CustomLinkProviderView(viewModel: .preview)
            .frame(maxHeight: 100)
        
        CustomLinkProviderView(viewModel: .preview)
            .frame(maxHeight: 150)
        
        CustomLinkProviderView(viewModel: .preview)
    }
}
