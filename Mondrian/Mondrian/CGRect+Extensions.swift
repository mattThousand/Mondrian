//
//  CGRect+Extensions.swift
//  Mondrian
//
//  Created by Matthew Buckley on 9/13/16.
//  Copyright © 2016 Nice Things. All rights reserved.
//

import Foundation

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

extension CGRect: Partitionable {
    public typealias NodeData = CGRect

    public func partitioned(withRootValue rootValue: CGRect, minValue: CGRect) -> [CGRect] {
        return [CGRect.zero]
    }

    public func treeRepresentation(withRootValue rootValue: CGRect) -> Tree<CGRect> {
        return Tree.empty
    }
}


public protocol Numeric {}

extension CGFloat: Numeric {}
extension Double: Numeric {}
extension Float: Numeric {}
extension Int: Numeric {}
