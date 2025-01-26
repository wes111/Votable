//
//  CandidatesView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/20/23.
//

import Navigator
import SwiftUI

struct CandidatesView: View {
    @Environment(\.navigator) var navigator: Navigator
    @State private var viewModel: CandidatesViewModel
    
    init() {
        viewModel = .init()
    }
    
    var body: some View {
        EmptyView()
//        List {
//            Group {
//                Section {
//                    ForEach(viewModel.representatives) { candidate in
//                        CandidateCardView(
//                            candidate: candidate
//                        )
//                    }
//                } header: {
//                    HeaderWithDropDownFilter(
//                        title: "Representatives",
//                        menuItems: RepresentativeType.allCases,
//                        selectedItem: $viewModel.representativesFilter
//                    )
//                }
//                
//                Section {
//                    ForEach(viewModel.candidates) { candidate in
//                        CandidateCardView(
//                            candidate: candidate
//                        )
//                    }
//                } header: {
//                    HeaderWithDropDownFilter(
//                        title: "Candidates",
//                        menuItems: RepresentativeType.allCases,
//                        selectedItem: $viewModel.candidatesFilter
//                    )
//                }
//            }
//            .listRowInsets(EdgeInsets())
//            .listRowSeparator(.hidden)
//        }
        .headerProminence(.increased)
        .listStyle(PlainListStyle())
        .refreshable {
            viewModel.refreshCandidates()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    navigator.navigate(to: CommunityDestination.createCandidate)
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

// MARK: - Preview
#Preview {
    CandidatesView()
}
