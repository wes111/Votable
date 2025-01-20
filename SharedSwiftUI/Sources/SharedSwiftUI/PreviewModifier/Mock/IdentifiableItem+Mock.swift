//
//  Identifiable+Mock.swift
//  SharedSwiftUI
//
//  Created by Wesley Luntsford on 1/17/25.
//

import Foundation

public struct IdentifiableItem: Identifiable, Sendable {
    public let id = UUID()
}

public extension IdentifiableItem {
    static let mockArray: [IdentifiableItem] = (0..<25).map { _ in IdentifiableItem() }
}
