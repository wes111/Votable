//
//  CommunityCategoriesView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import SwiftUI
import SharedSwiftUI
import DemocracySwiftUI

struct CommunityCategoriesView: View {
    @State var viewModel: CommunityCategoriesViewModel
    @FocusState private var focusedField: CommunityFlow?
    
    var body: some View {
        SubmittableTextInputView(viewModel: viewModel, focusedField: $focusedField) {
            VStack(alignment: .leading, spacing: ViewConstants.extraLargeElementSpacing) {
                DefaultTextInputField(text: $viewModel.text, fieldType: CommunityCategoryField.self)
                    .standardTextFieldStyle(
                        text: $viewModel.text,
                        focusedField: $focusedField,
                        focusedFieldValue: .categories,
                        fieldType: CommunityCategoryField.self,
                        buttonContent: .init(
                            action: viewModel.onSubmit,
                            image: .arrowRight,
                            isDisabled: viewModel.text.isEmpty
                        )
                    )
                
                CategoriesVStack(
                    selectedCategories: [],
                    categories: viewModel.categories,
                    action: .removeItem(viewModel.removeCategory(_:))
                )
            }
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        CommunityInputFlowView(viewModel: .preview(flowPath: .categories))
    }
}
