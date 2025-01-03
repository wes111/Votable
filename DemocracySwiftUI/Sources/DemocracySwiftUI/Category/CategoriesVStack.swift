//
//  CategoriesVStack.swift
//  DemocracySwiftUI
//
//  Created by Wesley Luntsford on 12/31/24.
//

import SwiftUI
import SharedSwiftUI

public struct CategoriesVStack<T: SelectableItem>: View {
    @Environment(\.theme) var theme: Theme
    var selectedCategories: [T]
    var categories: [T]
    let action: SelectableItemAction<T>
    
    public init(
        selectedCategories: [T],
        categories: [T],
        action: SelectableItemAction<T>
    ) {
        self.selectedCategories = selectedCategories
        self.categories = categories
        self.action = action
    }
    
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.sizeConstants.smallElementSpacing) {
                ForEach(categories, id: \.name) { category in
                    CategoryView(
                        category: category,
                        isSelected: selectedCategories.contains(category),
                        tapAction: action
                    )
                }
            }
            .animation(.easeOut(duration: theme.sizeConstants.animationLength), value: categories)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .scrollBounceBehavior(.basedOnSize, axes: [.vertical])
    }
}
