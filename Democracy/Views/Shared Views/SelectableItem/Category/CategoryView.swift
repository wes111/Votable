//
//  CategoryView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/28/24.
//

import SharedSwiftUI
import SwiftUI

struct CategoriesVStack<T: SelectableItem>: View {
    var selectedCategories: [T]
    var categories: [T]
    let action: SelectableItemAction<T>
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: ViewConstants.smallElementSpacing) {
                ForEach(categories, id: \.name) { category in
                    CategoryView(
                        category: category,
                        isSelected: selectedCategories.contains(category),
                        tapAction: action
                    )
                }
            }
            .animation(.easeOut(duration: ViewConstants.animationLength), value: categories)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .scrollBounceBehavior(.basedOnSize, axes: [.vertical])
    }
}

struct CategoryView<T: SelectableItem>: View {
    let category: T
    let isSelected: Bool
    let tapAction: SelectableItemAction<T>
    
    init(category: T, isSelected: Bool = false, tapAction: SelectableItemAction<T>) {
        self.category = category
        self.isSelected = isSelected
        self.tapAction = tapAction
    }
    
    var body: some View {
        Button {
            if case .toggleItem(let action) = tapAction {
                action(category)
            } else {
                return
            }
        } label: {
            HStack(alignment: .center, spacing: ViewConstants.smallElementSpacing) {
                Text(category.name)
                
                Spacer()
                
                if case .removeItem(let removeTagAction) = tapAction {
                    RemoveButton(item: category, action: removeTagAction)
                }
                
                if case .toggleItem(_) = tapAction {
                    Image(systemName: SystemImage.checkmarkCircleFill.rawValue)
                        .font(.footnote)
                        .opacity(isSelected ? 1.0 : 0.0)
                        .foregroundStyle(Color.green)
                }
            }
            .padding(ViewConstants.innerBorder)
            .background(
                Color.onBackground,
                in: RoundedRectangle(cornerRadius: ViewConstants.cornerRadius)
            )
            .foregroundStyle(Color.secondaryText)
            .overlay(
                RoundedRectangle(cornerRadius: ViewConstants.cornerRadius)
                    .strokeBorder(
                        isSelected ? Color.tertiaryText : .clear,
                        lineWidth: ViewConstants.thinBorderWidth
                    )
            )
        }
    }
}
