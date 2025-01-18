//
//  AddCommentView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 5/30/24.
//

import SharedSwiftUI
import SwiftUI

// TODO: Add a cancel button as a keyboard tool...
@MainActor
struct AddCommentView: View {
    @Environment(\.theme) var theme: Theme
    @State private var viewModel: PostViewModel
    @FocusState.Binding var isAddCommentFieldFocused: Bool?
    
    init(viewModel: PostViewModel, focusState: FocusState<Bool?>.Binding) {
        self.viewModel = viewModel
        self._isAddCommentFieldFocused = focusState
    }
    
    var body: some View {
        content
    }
}

// MARK: - Subviews
private extension AddCommentView {
    
    var content: some View {
        VStack(spacing: theme.sizeConstants.smallElementSpacing) {
            CustomDivider()
            
            VStack(spacing: theme.sizeConstants.elementSpacing) {
                if let isAddCommentFieldFocused, isAddCommentFieldFocused {
                    header
                }
                
                HStack(spacing: theme.sizeConstants.smallElementSpacing) {
                    textEditor
                    sendButton
                }
            }
            .padding([.horizontal, .bottom], theme.sizeConstants.screenPadding)
        }
        .background(theme.primaryColorScheme.primaryBackground)
    }
    
    var sendButton: some View {
        AsyncButton(showProgressView: $viewModel.isLoading) {
            await viewModel.submitComment()
        } label: {
            Image(systemName: SystemImage.paperPlane.rawValue)
                .font(.title2)
                .foregroundStyle(theme.primaryColorScheme.secondaryText)
        }
    }
    
    var header: some View {
        HStack {
            description
            Spacer()
        }
    }
    
    var description: some View {
        Text(viewModel.replyText)
            .foregroundStyle(theme.primaryColorScheme.tertiaryText)
            .font(.footnote)
    }
    
    var textEditor: some View {
        TextEditor(text: $viewModel.commentText)
            .standarCommentStyle(
                focusedFieldValue: true,
                text: $viewModel.commentText,
                focusedField: $isAddCommentFieldFocused,
                placeHolder: "Add your comment..."
            )
    }
}

// MARK: - Preview
#Preview {
    @Previewable @Environment(\.theme) var theme: Theme
    @Previewable @FocusState var focusedField: Bool?
    
    ZStack {
        AddCommentView(viewModel: .preview, focusState: $focusedField)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
    .background(theme.primaryColorScheme.primaryBackground)
}
