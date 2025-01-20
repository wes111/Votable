//
//  HorizontalSelectableList.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/11/24.
//

import SwiftUI

public struct HorizontalSelectableList<T: Selectable>: View {
    @Environment(\.theme) var theme: Theme
    @Binding var selection: T
    
    public init(selection: Binding<T>) {
        self._selection = selection
    }
    
    public var body: some View {
        ScrollView(.horizontal) {
            HStack(alignment: .center, spacing: theme.sizeConstants.smallElementSpacing) {
                ForEach(T.allCases) { option in
                    optionView(option)
                }
            }
        }
        .scrollClipDisabled()
        .scrollIndicators(.hidden)
    }
    
    func optionView(_ option: T) -> some View {
        return Text(option.title)
        // This is not a tag.... should be something different
            //.tagModifier(backgroundColor: selection == option ? theme.primaryColorScheme.primaryAccent : theme.primaryColorScheme.secondaryBackground)
            .onTapGesture {
                selection = option
            }
    }
}

// MARK: - Preview
#Preview(traits: .standardPreviewModifier) {
    @Previewable @State var category: MockSelectable = .mockFour
    
    HorizontalSelectableList(selection: $category)
}
