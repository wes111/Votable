//
//  HorizontalSelectableList.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/11/24.
//

import DemocracySwiftUI
import SharedSwiftUI
import SwiftUI
import SharedResourcesClientAndServer

struct HorizontalSelectableList<T: Selectable>: View {
    
    @Binding var selection: T
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(alignment: .center, spacing: ViewConstants.smallElementSpacing) {
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
            .tagModifier(backgroundColor: selection == option ? .otherRed : .onBackground)
            .onTapGesture {
                selection = option
            }
    }
}

// MARK: - Preview
#Preview {
    @Previewable @State var category: SelectableResourceCategory = .init(.book)
    
    ZStack {
        Color.primaryBackground.ignoresSafeArea()
        HorizontalSelectableList(selection: $category)
    }
}
