//
//  CommunityCandidateView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 8/16/24.
//

import DemocracySwiftUI
import SwiftUI
import SharedResourcesClientAndServer
import SharedSwiftUI

@Observable @MainActor
final class CommunityCandidateViewModel {
    let candidateTags: [SelectableCandidateTag] = CandidateTag.previewArray.map { SelectableCandidateTag($0) }
    let candidate: Candidate = .preview
    
    var supportButtonString: String = "Support"
}

// To get to this view, tap on the candidate card from CommunityView.
@MainActor
struct CommunityCandidateView: View {
    @Environment(\.theme) var theme: Theme
    @Environment(\.openURL) var openURL
    @State private var viewModel: CommunityCandidateViewModel
    
    init(viewModel: CommunityCandidateViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        primaryContent
            .toolbarNavigation(
                leadingContent: topBarLeadingContent,
                centerContent: topBarCenterContent,
                theme: theme
            )
    }
}

// MARK: - Subviews
private extension CommunityCandidateView {
    
    var primaryContent: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.sizeConstants.smallElementSpacing) {
                Group {
                    header
                    tags
                    CustomDivider()
                }
                .padding(.horizontal, theme.sizeConstants.screenPadding)
                
                summary
                    .padding(.vertical, theme.sizeConstants.sectionSpacing)
            }
            .foregroundStyle(theme.primaryColorScheme.primaryText)
        }
        .clipped()
        .scrollBounceBehavior(.basedOnSize, axes: [.vertical])
        .background(theme.primaryColorScheme.primaryBackground, ignoresSafeAreaEdges: .all)
    }
    
    var summary: some View {
        Text(viewModel.candidate.summary)
            .font(.callout)
            .fontWeight(.regular)
            .foregroundStyle(theme.primaryColorScheme.primaryText)
            .padding(.horizontal, theme.sizeConstants.screenPadding)
    }
    
    var topBarLeadingContent: [TopBarContent] {
        [.back({})]
    }
    
    var topBarCenterContent: [TopBarContent] {
        [.title(viewModel.candidate.candidateName, size: .small)]
    }
    
    var tags: some View {
        TagsFlow(
            selectedItems: [],
            items: viewModel.candidateTags,
            tagAction: .none
        )
    }
    
    var header: some View {
        VStack {
            HStack(alignment: .center, spacing: theme.sizeConstants.elementSpacing) {
                Circle()
                    .frame(height: 75)
                
                tiles
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 0) {
                    Text(viewModel.candidate.campaignSlogan)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundStyle(theme.primaryColorScheme.primaryText)
                        
                    if let link = viewModel.candidate.externalLink {
                        Button {
                            openURL(link)
                        } label: {
                            Label {
                                Text(link.absoluteString)
                            } icon: {
                                Image(systemName: SystemImage.link.rawValue)
                            }
                        }
                        .foregroundStyle(Color.blue)
                        .font(.subheadline)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Button {
                    // TODO: ...
                } label: {
                    Text(viewModel.supportButtonString)
                }
                .buttonStyle(ExtraSmallSecondaryButtonStyle())
            }
        }
    }
    
    // These are all buttons that go to a new page.
    // Supporters, Supporting, Contribution counts
    var tiles: some View {
        HStack(spacing: 10) {
            InfoTile(title: "1,890", subtitle: "Supporters") {
                print("Tapped Info Tile")
            }
            
            InfoTile(title: "1,999", subtitle: "Supporting") {
                print("Tapped Info tile")
            }
            
            InfoTile(title: "573", subtitle: "Contributions") {
                print("Tapped Info tile")
            }
        }
    }
}

struct InfoTile: View {
    @Environment(\.theme) var theme: Theme
    let title: String
    let subtitle: String
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            VStack(alignment: .center, spacing: 0) {
                Text(title)
                    .font(.footnote)
                
                Text(subtitle)
                    .font(.caption2)
            }
            .fontWeight(.medium)
            .padding(theme.sizeConstants.smallInnerBorder)
            .foregroundStyle(theme.primaryColorScheme.primaryText)
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        CommunityCandidateView(viewModel: .preview)
    }
}
