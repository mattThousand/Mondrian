//
//  Partitionable.swift
//  Mondrian
//
//  Created by Matthew Buckley on 9/10/16.
//  Copyright © 2016 Nice Things. All rights reserved.
//

import Foundation
import UIKit

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

public protocol TreeRepresentable {

    associatedtype NodeData: Comparable

}

public extension TreeRepresentable {

    static func treeRepresentation(withRootValue rootValue: NodeData) -> Tree<NodeData> {
        return Tree.cons(Tree.empty, rootValue, Tree.empty)
    }

}

public protocol Partitionable: TreeRepresentable {

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

public extension Partitionable {

    // this is a tree, should simply add 2 nodes to the current node
    public static func partitioned(withRootValue rootValue: NodeData, transform: (NodeData) -> (NodeData, NodeData), minValue: NodeData) -> [NodeData] {
        let tree = treeRepresentation(withRootValue: rootValue)
        switch tree {
        case .empty:
            return []
        case .cons(_, _, _):
            return tree.partitioned(usingTransform: transform, minValue: minValue).leafNodes

        }
    }

}
