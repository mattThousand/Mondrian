//
//  RectType.swift
//  Mondrian
//
//  Created by Matthew Buckley on 8/23/17.
//  Copyright © 2017 Nice Things. All rights reserved.
//

import Foundation

struct RectType: RectRepresentable {

    var origin: CoordinateType
    var width: Int
    var height: Int

    static var zero = RectType(origin: CoordinateType.zero, width: 0, height: 0)

    static func ==(lhs: RectType, rhs: RectType) -> Bool {
        return (lhs.height != rhs.height || lhs.width != rhs.width) || (lhs.origin != rhs.origin)
    }

}

extension RectType: TreeRepresentable {
    typealias NodeData = RectType
}

extension RectType: Partitionable {}
