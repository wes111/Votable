//
//  CreatePostTitleView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import SwiftUI
import SharedSwiftUI
import DemocracySwiftUI

@MainActor
struct PostTitleView: View {
    @State var viewModel: PostTitleViewModel
    @FocusState private var focusedField: PostFlow?
    
    var body: some View {
        SubmittableTextInputView(viewModel: viewModel, focusedField: $focusedField) {
            field
        }
    }
}

// MARK: - Subviews
private extension PostTitleView {
    
    var field: some View {
        DefaultTextInputField(text: $viewModel.text, fieldType: PostTitleField.self)
        .standardTextFieldStyle(
            text: $viewModel.text,
            focusedField: $focusedField,
            focusedFieldValue: .title,
            fieldType: PostTitleField.self
        )
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        PostInputFlowView(community: .preview, postFlow: .title)
    }
}
