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

    public static func partitioned(withRootValue rootValue: NodeData, nodeTransform: @escaping (NodeData) -> (NodeData, NodeData), minValue: NodeData) -> [NodeData] {
        let tree = treeRepresentation(withRootValue: rootValue)
        switch tree {
        case .empty:
            return []
        case .cons(_, let value, _):
            if value > minValue {
                return tree.partitioned(usingTransform: nodeTransform).leafNodes.flatMap({ node in
                    return self.partitioned(withRootValue: node, nodeTransform: nodeTransform, minValue: minValue)
                })
            } else {
                return tree.leafNodes
            }
        }
    }

}
