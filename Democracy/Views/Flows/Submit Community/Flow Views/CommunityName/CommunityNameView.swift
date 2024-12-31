//
//  CommunityNameView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import SwiftUI
import SharedResourcesClientAndServer

@MainActor
struct CommunityNameView: View {
    @State var viewModel: CommunityNameViewModel
    @FocusState private var focusedField: CommunityFlow?
    
    var body: some View {
        SubmittableTextInputView(viewModel: viewModel, focusedField: $focusedField) {
            field
        }
    }
}

// MARK: - Subviews
private extension CommunityNameView {
    
    var field: some View {
        DefaultTextInputField(text: $viewModel.text, fieldType: CommunityNameField.self)
            .standardTextFieldStyle(
                text: $viewModel.text,
                focusedField: $focusedField,
                focusedFieldValue: .name,
                fieldType: CommunityNameField.self
            )
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        CommunityInputFlowView(viewModel: .preview(flowPath: .name))
    }
}
