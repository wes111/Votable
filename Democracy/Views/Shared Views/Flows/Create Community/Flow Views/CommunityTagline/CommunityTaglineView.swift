//
//  CommunityTaglineView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 4/13/24.
//

import SwiftUI
import SharedSwiftUI
import DemocracySwiftUI

@MainActor
struct CommunityTaglineView: View {
    @State var viewModel: CommunityTaglineViewModel
    @FocusState private var focusedField: CommunityFlow?
    
    var body: some View {
        SubmittableTextInputView(viewModel: viewModel, focusedField: $focusedField) {
            field
        }
    }
}

// MARK: - Subviews
private extension CommunityTaglineView {
    
    var field: some View {
        DefaultTextInputField(text: $viewModel.text, fieldType: CommunityTaglineField.self)
            .standardTextFieldStyle(
                text: $viewModel.text,
                focusedField: $focusedField,
                focusedFieldValue: .tagline,
                fieldType: CommunityTaglineField.self
            )
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        CommunityInputFlowView(flowPath: .tagline)
    }
}
