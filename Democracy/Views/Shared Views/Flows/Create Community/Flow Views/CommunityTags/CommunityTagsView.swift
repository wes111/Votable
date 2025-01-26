//
//  CommunityTagsView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import SwiftUI
import SharedSwiftUI
import DemocracySwiftUI

struct CommunityTagsView: View {
    @Environment(\.theme) var theme: Theme
    @State var viewModel: CommunityTagsViewModel
    @FocusState private var focusedField: CommunityFlow?
    
    var body: some View {
        SubmittableTextInputView(viewModel: viewModel, focusedField: $focusedField) {
            VStack(alignment: .leading, spacing: theme.sizeConstants.extraLargeElementSpacing) {
                field
                
                TagsFlow(
                    selectedItems: [],
                    items: viewModel.tags,
                    tagAction: .removeItem(viewModel.removeTag)
                )
            }
        }
    }
}

// MARK: - Subviews
private extension CommunityTagsView {
    
    var field: some View {
        DefaultTextInputField(text: $viewModel.text, fieldType: CommunityTagField.self)
            .standardTextFieldStyle(
                text: $viewModel.text,
                focusedField: $focusedField,
                focusedFieldValue: .tags,
                fieldType: CommunityTagField.self,
                buttonContent: .init(
                    action: viewModel.onSubmit,
                    image: .arrowRight,
                    isDisabled: viewModel.text.isEmpty
                )
            )
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        CommunityInputFlowView(flowPath: .tags)
    }
}
