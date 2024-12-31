//
//  SelectableSummaryView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/5/24.
//

import SwiftUI

public struct SelectableSheetPickerView<T: Selectable>: View {
    @Binding var selection: T
    @State private var isPresented: Bool = false
    
    public init(selection: Binding<T>) {
        self._selection = selection
    }
    
    public var body: some View {
        TappableListItem(title: T.metaTitle, subtitle: selection.title, image: T.metaImage) {
            isPresented = true
        }
        .dynamicHeightSheet(isShowingSheet: $isPresented, sheetContent: {
            SelectablePickerDetailView(selectedCategory: $selection)
        })
    }
}

// MARK: - Preview
#Preview {
    @Previewable @State var mockSelectable: MockSelectable = .mockOne
    @Previewable @Environment(\.theme) var theme: Theme
    
    ZStack {
        theme.primaryColorScheme.primaryBackground.ignoresSafeArea()
        
        SelectableSheetPickerView(selection: $mockSelectable)
            .padding()
    }
}
