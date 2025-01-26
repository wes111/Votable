//
//  PostCategoryView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/30/23.
//

import DemocracySwiftUI
import SwiftUI

struct PostCategoryView: View {
    @State var viewModel: PostCategoryViewModel
    
    var body: some View {
        VStack {
            CategoriesVStack(
                selectedCategories: [viewModel.selectedCategory].compactMap { $0 },
                categories: viewModel.postCategories,
                action: .toggleItem(viewModel.toggleCategory(_:))
            )
            
            Spacer()
            SubmittableNextButton(viewModel: viewModel)
        }
        .onAppear {
            viewModel.setUserInput()
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        PostInputFlowView(community: .preview, postFlow: .category)
    }
}
