//
//  CommunityArchiveFeedView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/7/23.
//

import SharedSwiftUI
import SwiftUI
import SharedResourcesClientAndServer

struct CommunityArchiveFeedView: View {
    @Environment(\.theme) var theme: Theme
    @State private var viewModel: CommunityArchiveViewModel
    
    private var gridItemLayout: [GridItem] {
        Array(
            repeating: .init(.flexible(), spacing: theme.sizeConstants.elementSpacing),
            count: 2
        )
    }
    
    init(viewModel: CommunityArchiveViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        content
            .padding(.top, theme.sizeConstants.smallElementSpacing)
    }
}

// MARK: - Subviews
private extension CommunityArchiveFeedView {
    
    var content: some View {
        LazyVGrid(columns: gridItemLayout, alignment: .center, spacing: theme.sizeConstants.elementSpacing) {
            GridRow {
                communityCategory(nil)
            }
            
            ForEach(viewModel.categories, id: \.self) { category in
                communityCategory(category)
            }
        }
        .padding(.horizontal, theme.sizeConstants.screenPadding)
    }
    
    func communityCategory(_ category: PostCategory?) -> some View {
        Button {
            viewModel.goToCommunityPostCategory(category: category)
        } label: {
            VStack(alignment: .leading, spacing: theme.sizeConstants.smallElementSpacing) {
                Image("BMW")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .aspectRatio(1.75, contentMode: .fit)
                    .clipped()
                
                HStack(alignment: .center, spacing: 0) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text(viewModel.nameForCategory(category))
                            .foregroundStyle(theme.primaryColorScheme.primaryText)
                            .font(.subheadline)
                            .fontWeight(.bold)
                        
                        Text(viewModel.postCountStringForCategory(category))
                            .font(.caption2)
                            .foregroundColor(theme.primaryColorScheme.tertiaryText)
                    }
                    
                    Spacer()
                    
                    Image(systemName: SystemImage.chevronRight.rawValue)
                        .font(.subheadline)
                        .foregroundColor(theme.primaryColorScheme.tertiaryText)
                }
            }
            .padding(theme.sizeConstants.smallInnerBorder)
            .background(
                theme.primaryColorScheme.secondaryBackground,
                in: RoundedRectangle(cornerRadius: theme.sizeConstants.cornerRadius)
            )
        }
    }
}

// MARK: - Preview
#Preview {
    @Previewable @Environment(\.theme) var theme: Theme
    // PreviewService.registerMocks()
    ZStack {
        theme.primaryColorScheme.primaryBackground.ignoresSafeArea(.all)
        CommunityArchiveFeedView(viewModel: .preview)
    }
}
