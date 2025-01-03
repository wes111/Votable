//
//  CustomSecureField.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/2/23.
//

import SwiftUI
import SharedResourcesClientAndServer

@MainActor
public protocol PasswordCaseRepresentable: Hashable {
    var isPasswordCase: Bool { get }
    static var passwordCase: Self { get }
}

public struct CustomSecureField<Field: PasswordCaseRepresentable>: View {
    @Environment(\.theme) private var theme: Theme
    @Binding var secureText: String
    @FocusState.Binding var loginField: Field?
    @FocusState private var focusedField: SecureFocusField?
    @State private var isHidden = true
    @State private var didChangeFromVisibleToHidden = false
    let isNewPassword: Bool
    let field: Field
    
    public init(
        secureText: Binding<String>,
        loginField: FocusState<Field?>.Binding,
        isNewPassword: Bool,
        field: Field
    ) {
        self._secureText = secureText
        self._loginField = loginField
        self.isNewPassword = isNewPassword
        self.field = field
    }
    
    public var body: some View {
        HStack {
            ZStack {
                Group {
                    unsecureTextField
                    secureTextField
                }
                .keyboardType(.default)
                .textContentType(isNewPassword ? .newPassword : .password)
                .onTapGesture {
                    loginField = Field.passwordCase
                    focusedField = isHidden ? .hidden : .visible
                }
            }
            updateVisibilityButton
        }
        .geometryGroup() // Prevent button from bouncing incorrectly on keyboard dismiss.
        .standardTextInputAppearance(
            text: $secureText,
            focusedField: $loginField,
            focusedFieldValue: Field.passwordCase,
            fieldType: PasswordField.self
        )
        .onChange(of: loginField) { _, newValue in
            didChangeFromVisibleToHidden = false
            guard let newValue, newValue.isPasswordCase else { return }
            focusedField = isHidden ? .hidden : .visible
        }
        .onChange(of: isHidden) { wasHidden, isNowHidden in
            guard let loginField, loginField.isPasswordCase else { return }
            didChangeFromVisibleToHidden = !wasHidden && isNowHidden
            focusedField = isHidden ? .hidden : .visible
        }
        .onChange(of: secureText) { visibleText, newHiddenText in
            secureTextDidChange(
                visibleText: visibleText,
                newHiddenText: newHiddenText
            )
        }
    }
}

// MARK: - SubViews
private extension CustomSecureField {
    
    var unsecureTextField: some View {
        TextField(
            "Enter a password",
            text: $secureText,
            prompt: Text("Password").foregroundColor(theme.primaryColorScheme.tertiaryBackground)
        )
        .disabled(isHidden)
        .opacity(isHidden ? 0.0 : 1.0)
        .focused($focusedField, equals: .visible)
    }
    
    var secureTextField: some View {
        SecureField(
            "Enter a password",
            text: $secureText,
            prompt: Text("Password").foregroundColor(theme.primaryColorScheme.tertiaryBackground)
        )
        .opacity(isHidden ? 1.0 : 0.0)
        .focused($focusedField, equals: .hidden)
    }
    
    var updateVisibilityButton: some View {
        Button {
            withAnimation {
                isHidden.toggle()
            }
        } label: {
            Image(systemName: isHidden ? "eye": "eye.slash")
                .foregroundStyle(theme.primaryColorScheme.secondaryText)
        }
        .foregroundStyle(theme.primaryColorScheme.primaryText)
    }
}

// MARK: Private Methods
private extension CustomSecureField {
    
    func secureTextDidChange(visibleText: String, newHiddenText: String) {
        if didChangeFromVisibleToHidden {
            if newHiddenText.isEmpty { // The user pressed delete.
                secureText = String(visibleText.dropLast())
            } else if newHiddenText.count == 1 { // The user added a new character.
                secureText = visibleText + newHiddenText
            } else {
                // 'onChange' is in a bad state, so set the text to an emtpy string.
                secureText = ""
                // TODO: Remove! For debugging only!
                fatalError("original: \(visibleText), new: \(newHiddenText))")
            }
            didChangeFromVisibleToHidden = false
        }
    }
}

// MARK: - Private Helper Objects
private extension CustomSecureField {
    enum SecureFocusField {
        case hidden, visible
    }
}

// MARK: - Preview
#Preview {
    @Previewable @Environment(\.theme) var theme: Theme
    @Previewable @FocusState var focusedField: MockSelectable?
    
    ZStack {
        theme.primaryColorScheme.primaryBackground.ignoresSafeArea()
        
        CustomSecureField(
            secureText: .constant("Hello World"),
            loginField: $focusedField,
            isNewPassword: false,
            field: .mockOne
        )
        .padding()
    }
}
