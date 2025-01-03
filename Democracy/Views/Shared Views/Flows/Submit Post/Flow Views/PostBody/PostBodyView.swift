//
//  PostTitleView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import SwiftUI
import DemocracySwiftUI

@MainActor
struct PostBodyView: View {
    @State var viewModel: PostBodyViewModel
    @FocusState private var focusedField: PostFlow?
    
    var body: some View {
        SubmittableTextEditorInputView(viewModel: viewModel, focusedField: $focusedField) {
            field
        }
    }
}

// MARK: - Subviews
private extension PostBodyView {
    var field: some View {
        TextEditor(text: $viewModel.text)
            .defaultStyle(
                focusedFieldValue: PostFlow.body,
                text: $viewModel.text,
                focusedField: $focusedField,
                fieldType: PostBodyField.self
            )
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        PostInputFlowView(viewModel: .preview(flowPath: .body))
    }
}
