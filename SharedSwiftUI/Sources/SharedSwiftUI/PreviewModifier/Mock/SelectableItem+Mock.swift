//
//  SelectableItem+Mock.swift
//  SharedSwiftUI
//
//  Created by Wesley Luntsford on 1/17/25.
//

import Foundation

@MainActor
public struct SelectableItemMock: SelectableItem {
    public let name: String = "Mock Selectable Item"
}

public extension SelectableItemMock {
    static let mock: SelectableItemMock = .init()
    static let mockArray: [SelectableItemMock] = (0..<25).map { _ in .init() }
}
