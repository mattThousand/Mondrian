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

    
    /// Constructs a tree representation of the input
    ///
    /// - parameter rootValue: the value of the root node of the tree
    ///
    /// - returns: a Tree whose root node contains a value and whose leaf nodes are empty
    static func treeRepresentation(withRootValue rootValue: NodeData) -> Tree<NodeData> {
        return Tree.cons(Tree.empty, rootValue, Tree.empty)
    }

}
