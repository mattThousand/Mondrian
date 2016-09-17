//
//  MondrianTests.swift
//  MondrianTests
//
//  Created by Matthew Buckley on 9/9/16.
//  Copyright © 2016 Nice Things. All rights reserved.
//

import XCTest
@testable import Mondrian

class MondrianTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testCGRect() {

        let minRect = CGRect(origin: CGPoint.zero, size: CGSize(width: 10, height: 10))

        // Partitioned rect should contain at least multiple sub-rectangles
        XCTAssert(MondrianTests.partitionedRect(minRect: minRect).count > 2, "Partitioned rect should contain at least multiple sub-rectangles")
        
        // No rectangle should be smaller than the min value
        for leafNode in MondrianTests.partitionedRect(minRect: minRect) {
            XCTAssert(leafNode > minRect, "leaf node should not be larger than the min value")
        }
    }

    func testPerformanceExample() {

        let startTime = Date().timeIntervalSince1970
        let minRect = CGRect(origin: CGPoint.zero, size: CGSize(width: 10, height: 10))

        MondrianTests.partitionedRect(minRect: minRect)
        self.measure {
            let endTime = Date().timeIntervalSince1970

            print(endTime - startTime)
            XCTAssert(endTime - startTime < 1.0, "partitioning shouldn't take too long")
        }
    }
    
}

private extension MondrianTests {

    @discardableResult static func partitionedRect(minRect: CGRect) -> [CGRect] {
        
        let root = CGRect(origin: CGPoint.zero, size: CGSize(width: 1000, height: 1000))


        return CGRect.partitioned(withRootValue: root, minValue: minRect) { (parent) -> (CGRect, CGRect) in
            var c1 = CGRect.zero
            var c2 = CGRect.zero
            var bisectPt: CGFloat = 0.0
            
            if arc4random() % 2 == 0 {
                bisectPt = parent.height / CGFloat(arc4random_uniform(4) + 2)
                c1 = CGRect(origin: parent.origin, size: CGSize(width: parent.width, height: parent.height - bisectPt))
                c2 = CGRect(origin: CGPoint(x: c1.minX, y: c1.maxY), size: CGSize(width: parent.width, height: bisectPt))
            } else {
                bisectPt = parent.width / CGFloat(arc4random_uniform(4) + 2)
                c1 = CGRect(origin: parent.origin, size: CGSize(width: parent.width - bisectPt, height: parent.height))
                c2 = CGRect(origin: CGPoint(x: c1.maxX, y: c1.minY), size: CGSize(width: bisectPt, height: parent.height))
            }

            return (c1, c2)
        }

    }
    
}
