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
