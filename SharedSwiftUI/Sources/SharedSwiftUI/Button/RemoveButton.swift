//
//  RemoveButton.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/28/24.
//

import SwiftUI

public struct RemoveButton<T: SelectableItem>: View {
    @Environment(\.theme) var theme: Theme
    let item: T
    let action: (T) -> Void
    
    public init(
        item: T,
        action: @escaping (T) -> Void
    ) {
        self.item = item
        self.action = action
    }
    
    public var body: some View {
        Button {
            action(item)
        } label: {
            Image(systemName: SystemImage.xMark.rawValue)
                .font(.caption2)
                .foregroundStyle(theme.primaryColorScheme.secondaryText)
                .padding(6)
                .background(
                    Circle()
                        .fill(theme.primaryColorScheme.tertiaryBackground)
                )
        }
    }
}

// MARK: - Preview
#Preview(traits: .standardPreviewModifier) {
    @Previewable @State var showSelectableItem: Bool = true
    
    RemoveButton(item: SelectableItemMock()) { _ in
        showSelectableItem = false
    }
    .opacity(showSelectableItem ? 1.0 : 0.0)
    .task(id: showSelectableItem) {
        guard !showSelectableItem else {
            return
        }
        print("hello world")
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        showSelectableItem = true
    }
}
