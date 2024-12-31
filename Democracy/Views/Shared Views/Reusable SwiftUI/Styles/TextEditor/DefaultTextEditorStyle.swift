//
//  DefaultTextEditorStyle.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/18/23.
//

import Foundation
import SharedResourcesClientAndServer
import SwiftUI

@MainActor
extension TextEditor {
    private static let minFrameHeight: CGFloat = 200.0
    
    func defaultStyle<FocusedField: Hashable, Field: InputField>(
        focusedFieldValue: FocusedField,
        text: Binding<String>,
        focusedField: FocusState<FocusedField?>.Binding,
        fieldType: Field.Type
    ) -> some View {
        GeometryReader { geometry in
            self
                .standardTextInputAppearance(
                    text: text,
                    focusedField: focusedField,
                    focusedFieldValue: focusedFieldValue,
                    fieldPadding: .standardTextEditor,
                    fieldType: fieldType
                )
                .scrollContentBackground(.hidden)
                .cornerRadius(ViewConstants.cornerRadius)
                .frame(
                    minHeight: Self.minFrameHeight,
                    maxHeight: max(Self.minFrameHeight, geometry.size.height)
                )
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}
