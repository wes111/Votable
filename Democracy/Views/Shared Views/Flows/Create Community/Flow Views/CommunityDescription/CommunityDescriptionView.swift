//
//  CommunityDescriptionView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import SwiftUI
import DemocracySwiftUI

@MainActor
struct CommunityDescriptionView: View {
    @State var viewModel: CommunityDescriptionViewModel
    @FocusState private var focusedField: CommunityFlow?
    
    var body: some View {
        SubmittableTextEditorInputView(viewModel: viewModel, focusedField: $focusedField) {
            field
        }
    }
}

// MARK: - Subviews
private extension CommunityDescriptionView {
    
    var field: some View {
        TextEditor(text: $viewModel.text)
            .defaultStyle(
                focusedFieldValue: CommunityFlow.description,
                text: $viewModel.text,
                focusedField: $focusedField,
                fieldType: CommunityDescriptionField.self
            )
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        CommunityInputFlowView(flowPath: .description)
    }
}
