//
//  CategoryView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/28/24.
//

import SharedSwiftUI
import SwiftUI

struct CategoryView<T: SelectableItem>: View {
    @Environment(\.theme) var theme: Theme
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
            HStack(alignment: .center, spacing: theme.sizeConstants.smallElementSpacing) {
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
            .padding(theme.sizeConstants.innerBorder)
            .background(
                theme.primaryColorScheme.secondaryBackground,
                in: RoundedRectangle(cornerRadius: theme.sizeConstants.cornerRadius)
            )
            .foregroundStyle(theme.primaryColorScheme.secondaryText)
            .overlay(
                RoundedRectangle(cornerRadius: theme.sizeConstants.cornerRadius)
                    .strokeBorder(
                        isSelected ? theme.primaryColorScheme.tertiaryText : .clear,
                        lineWidth: theme.sizeConstants.thinBorderWidth
                    )
            )
        }
    }
}
