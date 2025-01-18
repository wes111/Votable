//
//  TagView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/27/24.
//

import SwiftUI
import SharedSwiftUI

public struct TagView<T: SelectableItem>: View {
    @Environment(\.theme) var theme: Theme
    let tag: T
    var isSelected: Bool
    let tagAction: SelectableItemAction<T>
    
    public init(tag: T, isSelected: Bool = false, tagAction: SelectableItemAction<T>) {
        self.tag = tag
        self.isSelected = isSelected
        self.tagAction = tagAction
    }
    
    public var body: some View {
        Button {
            if case .toggleItem(let action) = tagAction {
                action(tag)
            } else {
                return
            }
        } label: {
            HStack(alignment: .center, spacing: theme.sizeConstants.smallElementSpacing) {
                Text(tag.name)
                    .font(hasNoAction ? .footnote : .body)
                
                if case .removeItem(let removeTagAction) = tagAction {
                    RemoveButton(item: tag, action: removeTagAction)
                }
            }
            .tagModifier(backgroundColor: isSelected ? theme.primaryColorScheme.primaryAccent : theme.primaryColorScheme.secondaryBackground)
        }
    }
    
    private var hasNoAction: Bool {
        if case .none = tagAction {
            return true
        }
        return false
    }
}

// MARK: - Preview
#Preview(traits: .standardPreviewModifier) {
    TagView(tag: SelectableItemMock.mock, tagAction: .none)
}
