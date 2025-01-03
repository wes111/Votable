//
//  CommunityRulesView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import DemocracySwiftUI
import SharedSwiftUI
import SwiftUI

@MainActor
struct CommunityRulesView: View {
    @State var viewModel: CommunityRulesViewModel
    
    var body: some View {
        primaryContent
            .fullScreenCover(isPresented: $viewModel.isShowingAddRuleSheet) {
                AddRuleView(viewModel: viewModel)
            }
            .animation(.easeInOut, value: viewModel.isShowingAddRuleSheet)
            .dismissKeyboardOnDrag()
            .onAppear {
                viewModel.setUserInput()
            }
    }
}

// MARK: - Subviews
private extension CommunityRulesView {
    
    var primaryContent: some View {
        VStack(alignment: .leading, spacing: ViewConstants.elementSpacing) {
            addedRules()
            Spacer()
            addRuleButton
            SubmittableNextButton(viewModel: viewModel)
        }
    }
    
    var addRuleButton: some View {
        Button {
            viewModel.isShowingAddRuleSheet = true
        } label: {
            Text("Add Rule")
        }
        .buttonStyle(SecondaryButtonStyle())
    }
    
    func addedRules() -> some View {
        SnappingHorizontalScrollView(scrollContent: viewModel.rules) { rule in
            MenuCard(
                title: rule.title.value,
                description: rule.description.value
            ) {
                Button("Delete") { viewModel.removeRule(rule) }
                Button("Edit") { viewModel.beginEditingRule(rule) }
            }
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        CommunityInputFlowView(viewModel: .preview(flowPath: .rules))
    }
}
