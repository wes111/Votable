//
//  AlertableModifier.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/16/24.
//

import SwiftUI

fileprivate struct AlertableModifier: ViewModifier {
    @Binding var alertModel: NewAlertModel?
    
    init(alertModel: Binding<NewAlertModel?>) {
        self._alertModel = alertModel
    }
    
    func body(content: Content) -> some View {
        content
            .alert(item: $alertModel) { alert in
                Alert(
                    title: Text(alert.title),
                    message: Text(alert.description),
                    dismissButton: .default(Text("Okay"))
                )
            }
    }
}

// MARK: - View Extension
public extension View {
    func alertableModifier(alertModel: Binding<NewAlertModel?>) -> some View {
        modifier(AlertableModifier(alertModel: alertModel))
    }
}

// MARK: - Preview
#Preview(traits: .standardPreviewModifier) {
    @Previewable @State var alertModel: NewAlertModel?
    
    Button {
        alertModel = alertModel == nil ? .mock : nil
    } label: {
        Text("Show Alert")
    }
    .alertableModifier(alertModel: $alertModel)
}
