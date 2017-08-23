//
//  RectType.swift
//  Mondrian
//
//  Created by Matthew Buckley on 8/23/17.
//  Copyright © 2017 Nice Things. All rights reserved.
//

import Foundation

struct RectType: RectRepresentable {

    var width: Float
    var height: Float

    static func ==(lhs: RectType, rhs: RectType) -> Bool {
        return false
    }

}

extension RectType: TreeRepresentable {
    typealias NodeData = RectType
}

extension RectType: Partitionable {}
