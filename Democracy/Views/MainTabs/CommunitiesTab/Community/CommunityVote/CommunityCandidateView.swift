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
    @Environment(\.openURL) var openURL
    @State private var viewModel: CommunityCandidateViewModel
    
    init(viewModel: CommunityCandidateViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        primaryContent
            .toolbarNavigation(
                leadingContent: topBarLeadingContent,
                centerContent: topBarCenterContent
            )
    }
}

// MARK: - Subviews
private extension CommunityCandidateView {
    
    var primaryContent: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: ViewConstants.smallElementSpacing) {
                Group {
                    header
                    tags
                    CustomDivider()
                }
                .padding(.horizontal, ViewConstants.screenPadding)
                
                summary
                    .padding(.vertical, ViewConstants.sectionSpacing)
            }
            .foregroundStyle(Color.primaryText)
        }
        .clipped()
        .scrollBounceBehavior(.basedOnSize, axes: [.vertical])
        .background(Color.primaryBackground, ignoresSafeAreaEdges: .all)
    }
    
    var summary: some View {
        Text(viewModel.candidate.summary)
            .font(.callout)
            .fontWeight(.regular)
            .foregroundStyle(Color.primaryText)
            .padding(.horizontal, ViewConstants.screenPadding)
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
            HStack(alignment: .center, spacing: ViewConstants.elementSpacing) {
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
                        .foregroundStyle(Color.primaryText)
                        
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
            .padding(ViewConstants.smallInnerBorder)
            .foregroundStyle(Color.primaryText)
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        CommunityCandidateView(viewModel: .preview)
    }
}
