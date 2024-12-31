//
//  RemoveButton.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/28/24.
//

import SharedSwiftUI
import SwiftUI

struct RemoveButton<T: SelectableItem>: View {
    let item: T
    let action: @MainActor (T) -> Void
    
    var body: some View {
        Button {
            action(item)
        } label: {
            Image(systemName: SystemImage.xMark.rawValue)
                .font(.caption2)
                .foregroundStyle(Color.secondaryText)
                .padding(6)
                .background(
                    Circle()
                        .fill(Color.tertiaryBackground)
                )
        }
    }
}
