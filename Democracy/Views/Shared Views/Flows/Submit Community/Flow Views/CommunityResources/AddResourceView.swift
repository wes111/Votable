//
//  AddResourceView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/11/24.
//

import DemocracySwiftUI
import SharedSwiftUI
import SwiftUI
import SharedResourcesClientAndServer

// Text fields of the AddResourceView
enum AddResourceField: Hashable {
    case title, description, link
}

@MainActor
struct AddResourceView: View {
    @Bindable var viewModel: CommunityResourcesViewModel
    @FocusState private var focusedField: AddResourceField?
    @Environment(\.theme) var theme: Theme
    
    var body: some View {
        primaryContent
    }
}

// MARK: - Subviews
private extension AddResourceView {
    
    var primaryContent: some View {
        UserFormInputView(title: viewModel.flowCoordinator.viewTitle, alertModel: $viewModel.alertModel) {
            userInputStack
        } closeAction: {
            viewModel.closeAddResourceView()
        }
    }
    
    var userInputStack: some View {
        VStack(spacing: theme.sizeConstants.elementSpacing) {
            ScrollView {
                VStack(alignment: .leading, spacing: theme.sizeConstants.extraLargeElementSpacing) {
                    HorizontalSelectableList(
                        selection: Binding(
                            get: { SelectableResourceCategory(viewModel.category) },
                            set: { viewModel.category = $0.resourceCategory }
                        )
                    )
                    .titledElement(title: "Category")
                    
                    titleField
                    linkField
                    descriptionField
                }
            }
            .scrollBounceBehavior(.basedOnSize, axes: [.vertical])
            
            Spacer()
            addResourceButton
            cancelButton
        }
    }
    
    var addResourceButton: some View {
        Button {
            viewModel.addResource()
        } label: {
            Text(submitButtonTitle)
        }
        .buttonStyle(PrimaryButtonStyle())
        .disabled(!viewModel.canAddResource)
    }
    
    var cancelButton: some View {
        Button {
            viewModel.cancelEditingResource()
        } label: {
            Text("Cancel")
        }
        .buttonStyle(SecondaryButtonStyle())
    }
    
    var titleField: some View {
        DefaultTextInputField(text: $viewModel.title, fieldType: CommunityResourceTitleField.self, axis: .vertical)
            .lineLimit(2)
            .standardTextFieldStyle(
                text: $viewModel.title,
                focusedField: $focusedField,
                focusedFieldValue: AddResourceField.title,
                fieldType: CommunityResourceTitleField.self)
            .onSubmit {
                focusedField = .link
            }
            .titledElement(title: "Add a Title for the Resource")
    }
    
    var linkField: some View {
        DefaultTextInputField(text: $viewModel.link, fieldType: LinkField.self)
            .linkTextFieldStyle(
                link: $viewModel.link,
                focusedField: $focusedField,
                focusedFieldValue: AddResourceField.link
            )
            .onSubmit {
                focusedField = .description
            }
            .titledElement(title: "Add a Link for the Resource")
    }
    
    var descriptionField: some View {
        DefaultTextInputField(text: $viewModel.description, fieldType: CommunityResourceDescriptionField.self, axis: .vertical)
            .lineLimit(2...8)
            .standardTextFieldStyle(
                text: $viewModel.description,
                focusedField: $focusedField,
                focusedFieldValue: AddResourceField.description,
                fieldType: CommunityResourceDescriptionField.self)
            .onSubmit {
                focusedField = nil
                viewModel.addResource()
            }
            .titledElement(title: "Add a Description for the Resource")
    }
    
    var viewTitle: String {
        "\(viewModel.editingResource == nil ? "Add" : "Edit") Community Resource"
    }
    
    var submitButtonTitle: String {
        "\(viewModel.editingResource == nil ? "Add" : "Update") Resource"
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        CommunityInputFlowView(viewModel: .preview(flowPath: .resources))
    }
}
