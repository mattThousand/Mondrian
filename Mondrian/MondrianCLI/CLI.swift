//
//  CLI.swift
//  MondrianCLI
//
//  Created by Matthew Buckley on 8/22/17.
//  Copyright © 2017 Nice Things. All rights reserved.
//

import Foundation

public final class CLI {
    private let arguments: [String]

    public init(arguments: [String] = CommandLine.arguments) {
        self.arguments = arguments
    }

    public func run() throws {

        let rootRect = RectType(origin: CoordinateType(x: 0, y: 0), width: 10, height: 10)

        let tableau1 = RectType.partitioned(withRootValue: rootRect,
                                            minValue: RectType(origin: CoordinateType(x: 0,
                                                           y: 0),
                                                           width: 50.0,
                                                           height: 50.0)) { (parent) -> (RectType, RectType) in

                                                            var c1 = RectType.zero
                                                            var c2 = RectType.zero
                                                            var bisectPt: Float = 0.0

                                                            if arc4random() % 2 == 0 {
                                                                bisectPt = parent.height / Float(arc4random_uniform(4) + 2)
                                                                c1 = RectType(origin: parent.origin, width: parent.width, height: parent.height - bisectPt)
                                                                c2 = RectType(origin: CoordinateType(x: 0, y: Int(c1.height)), width: parent.width, height: bisectPt)
                                                            } else {
                                                                bisectPt = parent.width / Float(arc4random_uniform(4) + 2)
                                                                c1 = RectType(origin: parent.origin, width: parent.width - bisectPt, height: parent.height)
                                                                c2 = RectType(origin: CoordinateType(x: Int(c1.width), y: 0), width: bisectPt, height: parent.height)
                                                            }


                                                            return (c1, c2)
        }

        print(tableau1)
    }
}
