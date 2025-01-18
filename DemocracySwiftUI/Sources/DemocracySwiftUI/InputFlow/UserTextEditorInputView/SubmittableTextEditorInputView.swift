//
//  UserTextEditorInputView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import SwiftUI
import SharedSwiftUI

@MainActor
public protocol SubmittableTextEditorInputViewModelProtocol: TextInputFlowViewModel {
    associatedtype Selection: Hashable
    var selectedTab: Selection { get set }
    var markdown: String { get }
}

@MainActor
public struct SubmittableTextEditorInputView<ViewModel: SubmittableTextEditorInputViewModelProtocol, Field: View>: View {
    @Environment(\.theme) var theme: Theme
    @Bindable var viewModel: ViewModel
    @FocusState.Binding var focusedField: ViewModel.CoordinatorViewModel.Flow?
    @ViewBuilder let field: Field
    
    public init(
        viewModel: ViewModel,
        focusedField: FocusState<ViewModel.CoordinatorViewModel.Flow?>.Binding,
        @ViewBuilder field: () -> Field
    ) {
        self.viewModel = viewModel
        self._focusedField = focusedField
        self.field = field()
    }
    
    public var body: some View {
        primaryContent
    }
}

// MARK: - Subviews
private extension SubmittableTextEditorInputView {
    
    var primaryContent: some View {
        SubmittableTextInputView(viewModel: viewModel, focusedField: $focusedField) {
            VStack(alignment: .leading, spacing: theme.sizeConstants.elementSpacing) {
                picker
                tabView
            }
        }
    }
    
    var picker: some View {
        CustomPicker(
            title: "Picker",
            selection: $viewModel.selectedTab) {
                ForEach(PostBodyTab.allCases, id: \.self) { tab in
                    Text(tab.rawValue.capitalized).tag(tab)
                }
            }
    }
    
    var userPreview: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.sizeConstants.elementSpacing) {
                Text(viewModel.markdown)
                    .foregroundStyle(theme.primaryColorScheme.tertiaryText)
                    .lineLimit(nil)
                    .padding(.horizontal, 22.5)
                    .padding(.vertical, 25.5)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    var tabView: some View {
        TabView(selection: $viewModel.selectedTab) {
            field
                .tag(PostBodyTab.editor)
            
            userPreview
                .tag(PostBodyTab.preview)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .animation(.easeOut(duration: 0.2), value: viewModel.selectedTab)
    }
}

// MARK: - Preview
#Preview(traits: .standardPreviewModifier) {
    @Previewable @FocusState var focusedField: MockSubmittableViewModel.CoordinatorViewModel.Flow?
    
    SubmittableTextEditorInputView(
        viewModel: MockSubmittableViewModel(),
        focusedField: $focusedField
    ) {
        EmptyView()
    }
}
