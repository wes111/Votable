//
//  AddRuleView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/26/24.
//

import SharedSwiftUI
import SwiftUI
import DemocracySwiftUI

// Text fields of the AddRuleView
enum AddRuleField: Hashable {
    case title, description
}

struct AddRuleView: View {
    @Bindable var viewModel: CommunityRulesViewModel
    @FocusState private var focusedField: AddRuleField?
    @Environment(\.theme) var theme: Theme
    
    var body: some View {
        primaryContent
    }
}

extension AddRuleView {
    var primaryContent: some View {
        UserFormInputView(title: viewTitle, alertModel: $viewModel.alertModel) {
            userInputStack
        } closeAction: {
            viewModel.closeAddRuleView()
        }
    }
    
    var userInputStack: some View {
        VStack(spacing: theme.sizeConstants.elementSpacing) {
            ScrollView {
                VStack(alignment: .leading, spacing: theme.sizeConstants.extraLargeElementSpacing) {
                    titleField
                    descriptionField
                }
            }
            .scrollBounceBehavior(.basedOnSize, axes: [.vertical])
            
            Spacer()
            addRuleButton
            cancelButton
        }
        .frame(maxHeight: .infinity)
    }
    
    var titleField: some View {
        DefaultTextInputField(text: $viewModel.title, fieldType: CommunityRuleTitleField.self, axis: .vertical)
            .lineLimit(2)
            .standardTextFieldStyle(
                text: $viewModel.title,
                focusedField: $focusedField,
                focusedFieldValue: AddRuleField.title,
                fieldType: CommunityRuleTitleField.self
            )
            .onSubmit {
                focusedField = .description
            }
            .titledElement(title: "Add a Title for the Rule", theme: theme)
    }
    
    var descriptionField: some View {
        DefaultTextInputField(text: $viewModel.description, fieldType: CommunityRuleDescriptionField.self, axis: .vertical)
            .lineLimit(2...8)
            .standardTextFieldStyle(
                text: $viewModel.description,
                focusedField: $focusedField,
                focusedFieldValue: AddRuleField.description,
                fieldType: CommunityRuleDescriptionField.self)
            .onSubmit {
                focusedField = nil
                viewModel.addRule()
            }
            .titledElement(title: "Add a Description for the Rule", theme: theme)
    }
    
    var addRuleButton: some View {
        Button {
            viewModel.addRule()
        } label: {
            Text(submitButtonTitle)
        }
        .buttonStyle(PrimaryButtonStyle())
        .disabled(!viewModel.canAddRule)
    }
    
    var cancelButton: some View {
        Button {
            viewModel.cancelEditingRule()
        } label: {
            Text("Cancel")
        }
        .buttonStyle(SecondaryButtonStyle())
    }
    
    var viewTitle: String {
        "\(viewModel.editingRule == nil ? "Add" : "Edit") Community Rule"
    }
    
    var submitButtonTitle: String {
        "\(viewModel.editingRule == nil ? "Add" : "Update") Rule"
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        CommunityInputFlowView(viewModel: .preview(flowPath: .rules))
    }
}
