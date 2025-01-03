//
//  PostLinkView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import DemocracySwiftUI
import SwiftUI
import SharedSwiftUI

@MainActor
struct PostPrimaryLinkView: View {
    @State var viewModel: PostPrimaryLinkViewModel
    @FocusState private var focusedField: PostFlow?
    
    var body: some View {
        SubmittableTextInputView(viewModel: viewModel, focusedField: $focusedField) {
            field
        }
    }
}

// MARK: - Subviews
private extension PostPrimaryLinkView {
    
    var field: some View {
        DefaultTextInputField(
            text: $viewModel.text,
            fieldType: LinkField.self
        )
        .linkTextFieldStyle(
            link: $viewModel.text,
            focusedField: $focusedField,
            focusedFieldValue: .primaryLink
        )
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        PostInputFlowView(viewModel: .preview(flowPath: .primaryLink))
    }
}
