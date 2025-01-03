//
//  SelectableItemAction.swift
//  SharedSwiftUI
//
//  Created by Wesley Luntsford on 12/31/24.
//

import Foundation

public enum SelectableItemAction<T: SelectableItem> {
    case removeItem((T) -> Void)
    case toggleItem((T) -> Void)
    case none
}
