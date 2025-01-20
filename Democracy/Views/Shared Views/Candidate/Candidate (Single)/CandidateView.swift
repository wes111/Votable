//
//  CandidateView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/20/23.
//

import SharedSwiftUI
import SwiftUI
import SharedResourcesClientAndServer

struct CandidateView: View {
    @StateObject private var viewModel: CandidateViewModel
    @Environment(\.theme) var theme: Theme
    
    init(viewModel: CandidateViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .center, spacing: 20) {
                CandidateCard(
                    imageName: viewModel.candidate.imageName,
                    badges: viewModel.candidateBadges,
                    dateString: viewModel.memberSinceDate
                )
                .padding(.horizontal)
                
                Text("Posts")
                    .font(.title2)
                    .foregroundColor(theme.primaryColorScheme.tertiaryText)
                
                LazyVStack(alignment: .leading, spacing: 10) {
//                    ForEach(viewModel.candidatePosts) { post in
//                        PostCardView(viewModel: post)
//                    }
                }
            }
        }
    }
}

struct CandidateCard: View {
    @Environment(\.theme) var theme: Theme
    let imageName: String?
    let badges: [CandidateBadge]
    let dateString: String
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            Spacer()
            VStack(spacing: 15) {
                VStack(spacing: 2) {
                    if let imageName {
                        Image(imageName)
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .frame(maxWidth: 75)
                    } else {
                        EmptyView()
                    }
                    
                    HStack(spacing: 5) {
                        ForEach(badges) { _ in
                            Image(systemName: "star.fill")
                                .font(.caption)
                                .padding(4)
                                .background {
                                    Circle()
                                        .foregroundColor(theme.primaryColorScheme.primaryAccent)
                                }
                        }
                    }
                }
                
                VStack {
                    Text("Bernie Sanders")
                        .lineLimit(1)
                        .font(.system(.body, weight: .medium))
                    
                    Text("Title")
                        .font(.footnote)
                        .foregroundColor(theme.primaryColorScheme.tertiaryText)
                }
            }
            
            Spacer().frame(width: 25)
            
            VStack(spacing: 15) {
                VStack(spacing: 2) {
                    Text("1,000")
                        .font(.system(.subheadline, weight: .semibold))
                        
                    Text("Contributions")
                        .font(.caption2)
                        .foregroundColor(theme.primaryColorScheme.tertiaryText)
                }
                
                CustomDivider()
                
                VStack(spacing: 2) {
                    Text("1,000")
                        .font(.system(.subheadline, weight: .semibold))
                    
                    Text("Upvotes")
                        .font(.caption2)
                        .foregroundColor(theme.primaryColorScheme.tertiaryText)
                }

                CustomDivider()
                
                VStack(spacing: 2) {
                    Text(dateString)
                        .font(.system(.footnote, weight: .semibold))
                    
                    Text("Member Since")
                        .font(.caption2)
                        .foregroundColor(theme.primaryColorScheme.tertiaryText)
                }
            }
            Spacer()
        }
        .foregroundColor(theme.primaryColorScheme.primaryText)
        .padding(25)
        .background(theme.primaryColorScheme.secondaryBackground, in: RoundedRectangle(cornerRadius: 10))
    }
}

// MARK: - Preview
#Preview {
    @Previewable @Environment(\.theme) var theme: Theme
    ZStack {
        theme.primaryColorScheme.primaryBackground.ignoresSafeArea()
        CandidateView(viewModel: CandidateViewModel.preview)
    }
}
