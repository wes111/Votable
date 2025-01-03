//
//  Node.swift
//  SharedSwift
//
//  Created by Wesley Luntsford on 12/31/24.
//

import Foundation

@Observable
open class Node<Value> {
    public var value: Value
    public var children: [Node]? // This needs to be optional for SwiftUI's `OutlineGroup`.
    public weak var parent: Node?
    
    public init(value: Value) {
        self.value = value
    }
    
    public init(value: Value, children: [Node]) {
        self.value = value
        self.children = children
    }
    
    public init(value: Value, parent: Node?) {
        self.value = value
        self.parent = parent
    }
    
    public var isLastChild: Bool {
        guard let parent = parent, let siblings = parent.children else {
            return false
        }
        return siblings.last === self
    }
}

// MARK: - Computed Properties
public extension Node {
    
    var isRoot: Bool {
        return parent == nil
    }
    
    var isLeaf: Bool {
        return children == nil
    }
}

// MARK: - Methods
public extension Node {
    
    func addChild(_ child: Node) {
        if children == nil {
            children = []
        }
        children?.append(child)
        child.parent = self
    }
    
    func addChildren(_ newChildren: [Node]) {
        if children == nil {
            children = []
        }
        children?.append(contentsOf: newChildren)
        newChildren.forEach { $0.parent = self }
    }
    
    var depth: Int {
        var depth = 0
        var currentNode: Node? = self
        
        while let parent = currentNode?.parent {
            depth += 1
            currentNode = parent
        }
        
        return depth
    }
}

// MARK: - Extensions
extension Node: Equatable where Value: Equatable {
    public static func == (lhs: Node, rhs: Node) -> Bool {
        lhs.value == rhs.value && lhs.children == rhs.children
    }
}

extension Node: Hashable where Value: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(value)
        hasher.combine(children?.map { $0.value })
    }
}
