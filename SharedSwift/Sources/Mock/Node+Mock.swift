//
//  Node+Mock.swift
//  SharedSwift
//
//  Created by Wesley Luntsford on 1/17/25.
//

import Foundation

public final class MockNode: Node<String>, Identifiable {
    
    public var id: String {
        value.self
    }
    
    public var childMockNodes: [MockNode]? {
        // swiftlint:disable:next force_cast
        children as! [MockNode]?
    }
}

@MainActor
public extension MockNode {
    static let mockArray: [MockNode] = {
        let roots = (1...10).map { MockNode(value: "Root Node \($0)") }

        for root in roots {
            let children = (1...3).map { MockNode(value: "Child of \(root.value) \($0)") }
            root.addChildren(children)
            
            for child in children {
                let grandChildren = (1...2).map { MockNode(value: "Grandchild of \(child.value) \($0)") }
                child.addChildren(grandChildren)
            }
        }

        return roots
    }()
}
