//
//  CGRect+Extensions.swift
//  Mondrian
//
//  Created by Matthew Buckley on 9/13/16.
//  Copyright © 2016 Nice Things. All rights reserved.
//

import Foundation
import UIKit

extension CGRect: RectRepresentable {
    var width: Int {
        get {
            return Int(size.width)
        }
        set {
            size.width = CGFloat(newValue)
        }
    }
git
    var height: Int {
        get {
            return Int(size.height)
        }
        set {
            size.height = CGFloat(newValue)
        }
    }

}

extension CGRect: Partitionable {
    public typealias NodeData = CGRect
}
