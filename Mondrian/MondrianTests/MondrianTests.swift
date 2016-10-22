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

    func testTree() {
        let emptyTree = Tree<Int>.empty
        let nonEmptyChildTree = Tree<Int>.cons(Tree.empty, 4, Tree.empty)
        let treeWithLeafNodes = Tree.cons(nonEmptyChildTree, 4, nonEmptyChildTree)

        XCTAssert(emptyTree.leafNodes.count == 0, "empty tree should have zero leafnodes")
        XCTAssert(nonEmptyChildTree.leafNodes.count == 1, "tree with empty child nodes should have one leafnodes")
        XCTAssert(treeWithLeafNodes.leafNodes.count == 2, "tree with nonempty child nodes should have more than one leafnodes")
    }

    func testPartitionable() {

        let tree = Tree<CGRect>.empty

        XCTAssertThrowsError(try tree.partitioned(usingTransform: { (rect) -> (CGRect, CGRect) in
            return (rect, rect)
        }), "attempting to partition an empty tree should throw an error")
    }

    func testCGRect() {

        let minRect = CGRect(origin: CGPoint.zero, size: CGSize(width: 10, height: 10))

        let largerRect = CGRect(origin: CGPoint.zero, size: CGSize(width: 50, height: 10))

        let smallerRect = CGRect(origin: CGPoint.zero, size: CGSize(width: 5, height: 10))

        // CGRect should implement Comparable correctly
        XCTAssert(largerRect > minRect && smallerRect < minRect, "CGRect should implement Comparable correctly")

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

            XCTAssertLessThanOrEqual(endTime - startTime, 6.0, "Partitioning takes too long: \(endTime - startTime)")
        }
    }
    
}

private extension MondrianTests {

    @discardableResult static func partitionedRect(minRect: CGRect) -> [CGRect] {
        
        let root = CGRect(origin: CGPoint.zero, size: CGSize(width: 1000, height: 1000))


        return CGRect.partitioned(withRootValue: root, approximateValue: minRect) { (parent) -> (CGRect, CGRect) in
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
