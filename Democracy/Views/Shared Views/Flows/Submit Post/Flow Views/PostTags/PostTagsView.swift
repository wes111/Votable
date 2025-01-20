//
//  PostTagsView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import SwiftUI
import DemocracySwiftUI

@MainActor
struct PostTagsView: View {
    @State var viewModel: PostTagsViewModel
    
    var body: some View {
        VStack {
            tagsFlow
            Spacer()
            SubmittableNextButton(viewModel: viewModel)
        }
        .onAppear {
            viewModel.setUserInput()
        }
    }
}

// MARK: - Subviews
private extension PostTagsView {
    
    var tagsFlow: some View {
        TagsFlow(
            selectedItems: viewModel.selectedTags,
            items: viewModel.communityTags,
            tagAction: .toggleItem(viewModel.toggleTag(_:))
        )
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        PostInputFlowView(viewModel: .preview(flowPath: .tags))
    }
}
