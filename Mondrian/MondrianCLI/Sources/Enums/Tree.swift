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

    /// A collection containing the values of the leaf nodes of the tree
    var leafNodes: [NodeData] {
        switch self {
        case .empty:
            return []
        case .cons(let left, let value, let right):
            switch (left, right) {
            case (.empty, .empty):
                return [value]
            default:
                return left.leafNodes + right.leafNodes
            }
        }
    }

}

public extension Tree {

    /// Computes a new tree where the leaf nodes are transformations of the root node
    ///
    /// - parameter transform: a transformation function that takes NodeData as input and returns a transformed tuple of (NodeData, NodeData)
    ///
    /// - throws: this function throws an error of type MondrianError
    ///
    /// - returns: a new Tree where the leaf nodes are transformations of the root node
    public func partitioned(usingTransform transform: (NodeData)
        -> (NodeData, NodeData)) throws
        -> Tree<NodeData> {

        switch self {
        case .empty:
            throw MondrianError.partition("Cannot partition empty tree")
        case .cons(_, let parent, _):

            let childNodes = transform(parent)
            let leftNode = Tree.cons(Tree.empty, childNodes.0, Tree.empty)
            let rightNode = Tree.cons(Tree.empty, childNodes.1, Tree.empty)

            return Tree.cons(leftNode, parent, rightNode)
        }

    }

}
