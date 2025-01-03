//
//  NodeOutlineGroup.swift
//  Democracy
//
//  Created by Wesley Luntsford on 6/18/24.
//

import SwiftUI

// MARK: - https://stackoverflow.com/questions/62832809/list-or-outlinegroup-expanded-by-default-in-swiftui
// A custom OutlineGroup where each DisclosureGroup node is initially expanded.
public struct NodeOutlineGroup<Node, Content>: View where Node: Hashable, Node: Identifiable, Content: View {
    let node: Node
    let childKeyPath: KeyPath<Node, [Node]?>
    @State var isExpanded: Bool = true
    let content: (Node) -> Content
    
    public init(
        node: Node,
        childKeyPath: KeyPath<Node, [Node]?>,
        content: @escaping (Node) -> Content
    ) {
        self.node = node
        self.childKeyPath = childKeyPath
        self.content = content
    }
    
    public var body: some View {
        if node[keyPath: childKeyPath] != nil {
            DisclosureGroup(
                isExpanded: $isExpanded,
                content: {
                    if isExpanded {
                        ForEach(node[keyPath: childKeyPath]!) { childNode in
                            NodeOutlineGroup(
                                node: childNode,
                                childKeyPath: childKeyPath,
                                //isExpanded: isExpanded, // TODO: Did this break????
                                content: content
                            )
                        }
                    }
                },
                label: { content(node) })
        } else {
            content(node)
        }
    }
}

// MARK: - Preview
// TODO: ...
#Preview {
    EmptyView()
    // NodeOutlineGroup()
}
