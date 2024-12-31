//
//  TagView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/27/24.
//

import SwiftUI

protocol SelectableItem: Hashable {
    var name: String { get }
}

enum SelectableItemAction<T: SelectableItem> {
    case removeItem(@MainActor (T) -> Void)
    case toggleItem(@MainActor (T) -> Void)
    case none
}

struct TagView<T: SelectableItem>: View {
    let tag: T
    var isSelected: Bool
    let tagAction: SelectableItemAction<T>
    
    init(tag: T, isSelected: Bool = false, tagAction: SelectableItemAction<T>) {
        self.tag = tag
        self.isSelected = isSelected
        self.tagAction = tagAction
    }
    
    var body: some View {
        Button {
            if case .toggleItem(let action) = tagAction {
                action(tag)
            } else {
                return
            }
        } label: {
            HStack(alignment: .center, spacing: ViewConstants.smallElementSpacing) {
                Text(tag.name)
                    .font(hasNoAction ? .footnote : .body)
                
                if case .removeItem(let removeTagAction) = tagAction {
                    RemoveButton(item: tag, action: removeTagAction)
                }
            }
            .tagModifier(backgroundColor: isSelected ? .otherRed : .onBackground)
        }
    }
    
    private var hasNoAction: Bool {
        if case .none = tagAction {
            return true
        }
        return false
    }
}
