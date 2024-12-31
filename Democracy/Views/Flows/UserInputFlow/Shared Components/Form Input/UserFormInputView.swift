//
//  UserFormInputView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/26/24.
//

import SwiftUI

struct UserFormInputView<FormContent: View>: View {
    @Binding var alertModel: NewAlertModel?
    @ViewBuilder let formContent: FormContent
    let closeAction: () -> Void
    let title: String
    
    init(
        title: String,
        alertModel: Binding<NewAlertModel?>,
        @ViewBuilder content: () -> FormContent,
        closeAction: @escaping () -> Void
    ) {
        self.title = title
        self._alertModel = alertModel
        formContent = content()
        self.closeAction = closeAction
    }
    
    var body: some View {
        // Note: Using NavigationView instead of NavigationStack to fix bug with @FocusState
        // https://developer.apple.com/forums/thread/737399
        NavigationView { // Remove if this view needs navigation beyond closing.
            primaryContent
                .toolbarNavigation(
                    trailingContent: [.close(closeAction)]
                )
                .background(Color.primaryBackground.ignoresSafeArea())
                .alert(item: $alertModel) { alert in
                    Alert(
                        title: Text(alert.title),
                        message: Text(alert.description),
                        dismissButton: .default(Text("Okay"))
                    )
                }
        }
        .navigationViewStyle(.stack)
    }
}

// MARK: Subviews
private extension UserFormInputView {
    var primaryContent: some View {
        ZStack(alignment: .center) {
            Color.primaryBackground.ignoresSafeArea()
            
            // The GeometryReader here prevents the view from moving
            // with keyboard appearance/disappearance.
            GeometryReader { _ in
                VStack(alignment: .leading, spacing: ViewConstants.elementSpacing) {
                    Text(title)
                        .primaryTitle()
                    formContent
                }
                .padding(ViewConstants.screenPadding)
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
        }
    }
}

// MARK: - Preview
#Preview {
    UserFormInputView(title: "Form Input View", alertModel: .constant(nil)) {
        EmptyView()
    } closeAction: {
        return
    }
}