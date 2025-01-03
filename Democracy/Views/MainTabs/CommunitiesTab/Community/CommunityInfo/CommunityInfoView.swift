//
//  CommunityInfoView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/7/23.
//

import DemocracySwiftUI
import SwiftUI
import SharedResourcesClientAndServer
import SharedSwiftUI

@MainActor
struct CommunityInfoView: View {
    @State private var viewModel: CommunityInfoViewModel
    @Environment(\.theme) var theme: Theme
    @Environment(\.openURL) var openURL
    
    init(viewModel: CommunityInfoViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        content
    }
}

// MARK: - Subviews
private extension CommunityInfoView {
    
    var content: some View {
        VStack(alignment: .leading, spacing: theme.sizeConstants.smallElementSpacing) {
            representativesSection
            aboutSection
            rulesSection
            alliedCommunitiesSection
            resourcesSection
        }
        .padding(.top, theme.sizeConstants.smallElementSpacing)
    }
    
    var aboutSection: some View {
        VStack(alignment: .leading, spacing: theme.sizeConstants.elementSpacing) {
            Text(viewModel.description)
                .font(.caption)
                .foregroundColor(theme.primaryColorScheme.secondaryText)
                .padding(.horizontal, theme.sizeConstants.screenPadding)
            
            CustomDivider()
        }
        .sectionModifier(title: "Description")
    }
    
    var representativesSection: some View {
        VStack(
            alignment: .leading,
            // Offset for scroll indicator.
            spacing: theme.sizeConstants.elementSpacing - theme.sizeConstants.smallInnerBorder
        ) {
            ScrollView(.horizontal) {
                HStack(spacing: theme.sizeConstants.elementSpacing) {
                    ForEach(viewModel.candidates) { candidate in
                        representativeCard(candidate)
                    }
                }
                .padding(.bottom, theme.sizeConstants.smallInnerBorder) // Offset for scroll indicator.
            }
            .contentMargins(.horizontal, theme.sizeConstants.screenPadding, for: .scrollContent)
            .contentMargins(.horizontal, theme.sizeConstants.screenPadding, for: .scrollIndicators)
            
            CustomDivider()
        }
        .sectionModifier(title: "Representatives")
    }
    
    func representativeCard(_ rep: Candidate) -> some View {
        VStack(spacing: theme.sizeConstants.smallElementSpacing) {
            Image(rep.imageName ?? "")
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                .frame(width: 70, height: 70)
                .onTapGesture {
                    viewModel.onTapLeader(id: "")
                }
            
            VStack(spacing: 0) {
                Text(rep.userName)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(theme.primaryColorScheme.tertiaryText)
                    .minimumScaleFactor(0.75)
                    .lineLimit(1)
            }
        }
        .multilineTextAlignment(.center)
        .frame(width: 70)
    }
    
    var alliedCommunitiesSection: some View {
        VStack(alignment: .leading, spacing: theme.sizeConstants.elementSpacing) {
            ForEach(viewModel.alliedCommunities) { community in
                CommunityCard(viewModel: .init(community: community, coordinator: viewModel.coordinator))
            }
            .padding(.horizontal, theme.sizeConstants.screenPadding)
            
            CustomDivider()
        }
        .sectionModifier(title: "Allied Communities")
    }
    
    var rulesSection: some View {
        VStack(alignment: .leading, spacing: theme.sizeConstants.elementSpacing) {
            ForEach(Array(viewModel.rules.enumerated()), id: \.element) { index, rule in
                ruleView(rule, index: index)
            }
            .padding(.horizontal, theme.sizeConstants.screenPadding)
            
            CustomDivider()
        }
        .sectionModifier(title: "Rules")
    }
    
    func ruleView(_ rule: Rule, index: Int) -> some View {
        HStack(alignment: .top, spacing: theme.sizeConstants.smallElementSpacing) {
            Text("\(index)")
                .font(.title2)
                .padding(.trailing, 5)
                .foregroundColor(theme.primaryColorScheme.tertiaryText)
            
            VStack(alignment: .leading, spacing: theme.sizeConstants.extraSmallElementSpacing) {
                Text(rule.title)
                    .foregroundStyle(theme.primaryColorScheme.primaryText)
                    .font(.subheadline)
                    .fontWeight(.bold)
                
                Text(rule.description)
                    .font(.caption2)
                    .foregroundColor(theme.primaryColorScheme.tertiaryText)
            }
        }
    }
    
    func resourceView(_ resource: Resource) -> some View {
        Button {
            if let resourceLink = resource.link {
                openURL(resourceLink)
            }
        } label: {
            VStack(alignment: .leading, spacing: theme.sizeConstants.extraSmallElementSpacing) {
                HStack(alignment: .center, spacing: theme.sizeConstants.smallElementSpacing) {
                    if let image = SelectableResourceCategory(resource.category).image {
                        Image(systemName: image.rawValue)
                    }
                    
                    Text(resource.title)
                        .foregroundStyle(theme.primaryColorScheme.primaryText)
                        .font(.subheadline)
                        .fontWeight(.bold)
                }
                HStack(alignment: .lastTextBaseline, spacing: theme.sizeConstants.smallElementSpacing) {
                    if let description = resource.description {
                        Text(description)
                            .font(.caption2)
                            .foregroundColor(theme.primaryColorScheme.tertiaryText)
                    }
                    
                    if resource.link != nil {
                        Image(systemName: SystemImage.arrowUpRightSquare.rawValue)
                            .foregroundStyle(theme.primaryColorScheme.primaryText)
                    }
                }
            }
            .multilineTextAlignment(.leading)
            .padding(theme.sizeConstants.smallInnerBorder)
            .background(
                theme.primaryColorScheme.secondaryBackground,
                in: RoundedRectangle(cornerRadius: theme.sizeConstants.cornerRadius)
            )
        }
    }
    
    var resourcesSection: some View {
        VStack(alignment: .leading, spacing: theme.sizeConstants.elementSpacing) {
            ForEach(viewModel.resources) { resource in
                resourceView(resource)
            }
            .padding(.horizontal, theme.sizeConstants.screenPadding)
            
            CustomDivider()
        }
        .sectionModifier(title: "Resources")
    }
}

// MARK: Helper ViewModifier

struct SectionModifier: ViewModifier {
    @Environment(\.theme) var theme: Theme
    let title: String
    
    func body(content: Content) -> some View {
        VStack(alignment: .leading, spacing: theme.sizeConstants.extraLargeElementSpacing) {
            Text(title)
                .foregroundStyle(theme.primaryColorScheme.primaryText)
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.horizontal, theme.sizeConstants.screenPadding)
            
            content
        }
    }
}

extension View {
    func sectionModifier(title: String) -> some View {
        self.modifier(SectionModifier(title: title))
    }
}

// MARK: - Preview
#Preview {
    @Previewable @Environment(\.theme) var theme: Theme
    ScrollView {
        CommunityInfoView(viewModel: CommunityInfoViewModel.preview)
            .background(theme.primaryColorScheme.primaryBackground)
    }
}
