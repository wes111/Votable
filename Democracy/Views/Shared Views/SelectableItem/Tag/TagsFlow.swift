//
//  TagsFlow.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/27/24.
//

import SwiftUI

struct TagsFlow<T: SelectableItem>: View {
    var selectedItems: [T]
    var items: [T]
    let tagAction: SelectableItemAction<T>
    
    var body: some View {
        ScrollView {
            NewFlowLayout(alignment: .center) {
                ForEach(items, id: \.self) { tag in
                    TagView(
                        tag: tag,
                        isSelected: selectedItems.contains(tag),
                        tagAction: tagAction
                    )
                }
            }
            .frame(maxWidth: .infinity)
        }
        .scrollBounceBehavior(.basedOnSize, axes: [.vertical])
    }
}
