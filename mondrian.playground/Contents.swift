//
//  Partitionable.swift
//  Mondrian
//
//  Created by Matthew Buckley on 9/10/16.
//  Copyright © 2016 Nice Things. All rights reserved.
//

import Foundation
import UIKit

enum PartitionAxis { case vertical, horizontal }

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

public protocol Numeric {}

extension CGFloat: Numeric {}
extension Double: Numeric {}
extension Float: Numeric {}
extension Int: Numeric {}

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

            print(minValue)
            print(childNodes.0)
            return childNodes.0 > minValue || childNodes.1 > minValue ? Tree.cons(leftNode.partitioned(usingTransform: transform, minValue: minValue), parent, rightNode.partitioned(usingTransform: transform, minValue: minValue)) : self
        }

    }

}

public extension Partitionable {

    // this is a tree, should simply add 2 nodes to the current node
    public static func partitioned(withRootValue rootValue: NodeData, transform: (NodeData) -> (NodeData, NodeData), minValue: NodeData) -> [NodeData] {
        print("hey")
        let tree = treeRepresentation(withRootValue: rootValue)
        print(tree)
        switch tree {
        case .empty:
            return []
        case .cons(_, _, _):
            return tree.partitioned(usingTransform: transform, minValue: minValue).leafNodes

        }
    }

}

extension CGRect: Partitionable {
    public typealias NodeData = CGRect

    public func partitioned(withRootValue rootValue: CGRect, minValue: CGRect) -> [CGRect] {
        return [CGRect.zero]
    }

    public func treeRepresentation(withRootValue rootValue: CGRect) -> Tree<CGRect> {
        return Tree.empty
    }
}

extension CGRect: Comparable {

    public static func <(lhs: CGRect, rhs: CGRect) -> Bool {
        return lhs.width * lhs.height < rhs.width * rhs.height
    }

    public static func <=(lhs: CGRect, rhs: CGRect) -> Bool {
        return lhs.width * lhs.height <= rhs.width * rhs.height
    }

    public static func >=(lhs: CGRect, rhs: CGRect) -> Bool {
        return lhs.width * lhs.height >= rhs.width * rhs.height
    }

    public static func >(lhs: CGRect, rhs: CGRect) -> Bool {
        return lhs.width * lhs.height > rhs.width * rhs.height
    }
}

print("yo")
let test = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0)

print(CGRect.partitioned(withRootValue: test, transform: { (parentRect: CGRect) in
    let c1 = CGRect(origin: parentRect.origin, size: CGSize(width: parentRect.width / 2.0, height: parentRect.height / 2.0))
    return (c1, c1)
    }, minValue: CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)))
