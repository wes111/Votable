//
//  CommunityLeadersView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import DemocracySwiftUI
import SharedSwiftUI
import SwiftUI

@MainActor
struct CommunityResourcesView: View {
    @State var viewModel: CommunityResourcesViewModel
    
    var body: some View {
        primaryContent
            .fullScreenCover(isPresented: $viewModel.isShowingAddResourceSheet) {
                AddResourceView(viewModel: viewModel)
            }
            .animation(.easeInOut, value: viewModel.isShowingAddResourceSheet)
            .dismissKeyboardOnDrag()
            .onAppear {
                viewModel.setUserInput()
            }
    }
}

// MARK: - Subviews
private extension CommunityResourcesView {
    
    var primaryContent: some View {
        VStack(alignment: .leading, spacing: ViewConstants.elementSpacing) {
            addedResources
            Spacer()
            addResourceButton
            SubmittableNextButton(viewModel: viewModel)
        }
    }
    
    var addedResources: some View {
        SnappingHorizontalScrollView(scrollContent: viewModel.resources) { resource in
            MenuCard(
                title: resource.title.value,
                description: resource.description.value
            ) {
                    Button("Delete") { viewModel.removeResource(resource) }
                    Button("Edit") { viewModel.beginEditingResource(resource) }
                }
        }
    }
    
    var addResourceButton: some View {
        Button {
            viewModel.isShowingAddResourceSheet = true
        } label: {
            Text("Add Resource")
        }
        .buttonStyle(SecondaryButtonStyle())
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        CommunityInputFlowView(viewModel: .preview(flowPath: .resources))
    }
}
