//
//  Tree.swift
//  Mondrian
//
//  Created by Matthew Buckley on 9/13/16.
//  Copyright © 2016 Nice Things. All rights reserved.
//

import Foundation

public enum Tree<NodeData: Comparable> {
    case empty
    indirect case cons(Tree<NodeData>, NodeData, Tree<NodeData>)


    var leafNodes: [NodeData] {
        switch self {
        case .empty:
            return []
        case .cons(let left, let value, let right):
            return left.leafNodes + [value] + right.leafNodes
        }
    }

}

public extension Tree {

    // this is a tree, should simply add 2 nodes to the current node
    public func partitioned(usingTransform transform: (NodeData) -> (NodeData, NodeData), minValue: NodeData) -> Tree<NodeData> {

        switch self {
        case .empty:
            return self
        case .cons(_, let parent, _):

            let childNodes = transform(parent)
            let leftNode = Tree.cons(Tree.empty, childNodes.0, Tree.empty)
            let rightNode = Tree.cons(Tree.empty, childNodes.1, Tree.empty)

            return childNodes.0 > minValue || childNodes.1 > minValue ? Tree.cons(leftNode.partitioned(usingTransform: transform, minValue: minValue), parent, rightNode.partitioned(usingTransform: transform, minValue: minValue)) : self
        }

    }

}
