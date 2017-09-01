//
//  RectRepresentable.swift
//  Mondrian
//
//  Created by Matthew Buckley on 8/23/17.
//  Copyright © 2017 Nice Things. All rights reserved.
//

import Foundation

protocol RectRepresentable: Comparable {

    static func <(lhs: Self, rhs: Self) -> Bool

    static func <=(lhs: Self, rhs: Self) -> Bool

    static func >=(lhs: Self, rhs: Self) -> Bool

    static func >(lhs: Self, rhs: Self) -> Bool

    var width: Int { get set }
    var height: Int { get set }

}

extension RectRepresentable {

    public static func <(lhs: Self, rhs: Self) -> Bool {
        return lhs.width * lhs.height < rhs.width * rhs.height
    }

    public static func <=(lhs: Self, rhs: Self) -> Bool {
        return lhs.width * lhs.height <= rhs.width * rhs.height
    }

    public static func >=(lhs: Self, rhs: Self) -> Bool {
        return lhs.width * lhs.height >= rhs.width * rhs.height
    }

    public static func >(lhs: Self, rhs: Self) -> Bool {
        return lhs.width * lhs.height > rhs.width * rhs.height
    }

}
