//
//  TreeRepresentable.swift
//  Mondrian
//
//  Created by Matthew Buckley on 9/13/16.
//  Copyright © 2016 Nice Things. All rights reserved.
//

import Foundation

public protocol TreeRepresentable { associatedtype NodeData: Comparable }

public extension TreeRepresentable {

    static func treeRepresentation(withRootValue rootValue: NodeData) -> Tree<NodeData> {
        return Tree.cons(Tree.empty, rootValue, Tree.empty)
    }

}
