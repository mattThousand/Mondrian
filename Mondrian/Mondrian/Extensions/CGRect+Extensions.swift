//
//  CGRect+Extensions.swift
//  Mondrian
//
//  Created by Matthew Buckley on 9/13/16.
//  Copyright © 2016 Nice Things. All rights reserved.
//

import Foundation
import UIKit

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
}
