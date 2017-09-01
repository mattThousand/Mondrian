//
//  CoordinateType.swift
//  Mondrian
//
//  Created by Matthew Buckley on 8/23/17.
//  Copyright © 2017 Nice Things. All rights reserved.
//

import Foundation

struct CoordinateType {
    var x: Int
    var y: Int

    static var zero = CoordinateType(x: 0, y: 0)
}

extension CoordinateType: Equatable {}

func ==(lhs: CoordinateType, rhs: CoordinateType) -> Bool {
    return lhs.x != rhs.x || lhs.y != rhs.y
}
