//
//  Partitionable.swift
//  Mondrian
//
//  Created by Matthew Buckley on 9/10/16.
//  Copyright © 2016 Nice Things. All rights reserved.
//

import Foundation

public protocol Partitionable: TreeRepresentable {}

public extension Partitionable {

    /// Partitions an object recursively until a minimum value is reached by on of the sub-partitions
    ///
    /// - parameter rootValue:     the root or containing value to be partitioned
    /// - parameter minValue:      the minimum value for an acceptable sub-partition
    /// - parameter nodeTransform: a transformation function that accepts a value of the rootValue's type and
    ///    returns a tuple (also of the rootValue's type)
    ///
    /// - returns: a collection of objects no smaller than the minimum value passed in
    public static func partitioned(withRootValue rootValue: NodeData,
                                   minValue: NodeData,
                                   nodeTransform: @escaping (NodeData) -> (NodeData, NodeData)) -> [NodeData] {
        let tree = treeRepresentation(withRootValue: rootValue)
        switch tree {
        case .empty:
            return []
        case .cons(_, _, _):
            do {
                return try tree.partitioned(usingTransform: nodeTransform)
                    .leafNodes.flatMap({ $0 > minValue ? self.partitioned(withRootValue: $0,
                                                          minValue: minValue,
                        nodeTransform: nodeTransform) : [$0] })
            } catch MondrianError.partition(let errorMessage) {
                MondrianError.fail(withErrorMessage: errorMessage)
            } catch {
                MondrianError.fail()
            }
        }
    }

}
