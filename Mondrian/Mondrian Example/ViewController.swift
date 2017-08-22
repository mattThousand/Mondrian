//
//  ViewController.swift
//  Mondrian Example
//
//  Created by Matthew Buckley on 9/14/16.
//  Copyright © 2016 Nice Things. All rights reserved.
//

import UIKit
import Mondrian

final class ViewController: UIViewController {

    let tileColors = [
        UIColor(red: 191/255, green: 0.0, blue: 0.0, alpha: 1.0),
        UIColor(red: 255/255, green: 247/255, blue: 0.0, alpha: 1.0),
        UIColor(red: 228/255, green: 247/255, blue: 247/255, alpha: 1.0),
        UIColor(red: 5/255, green: 0.0, blue: 239/255, alpha: 1.0),
        .white
    ]

    let borderColor = UIColor.black

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let viewRect = view.frame

        let tableau1 = CGRect.partitioned(withRootValue: viewRect,
                                          minValue: CGRect(x: 0.0,
                                                           y: 0.0,
                                                           width: 50.0,
                                                           height: 50.0)) { (parent) -> (CGRect, CGRect) in
            
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

        var idx = tileColors.count - 1
        for tile in tableau1 {
            let tileView = TileView(frame: tile)
            tileView.backgroundColor = tileColors[idx % tileColors.count]
            tileView.layer.borderWidth = 2.0
            tileView.layer.borderColor = borderColor.cgColor
            tileView.alpha = 0.0
            let dispatchTime: DispatchTime = DispatchTime.now() + Double(Int64(0.1 * Double(idx) * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
            OperationQueue.main.maxConcurrentOperationCount = 1
            DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
                let operation = BlockOperation {
                    self.view.addSubview(tileView)
                }
                OperationQueue.main.addOperation(operation)
            })
            idx += 1
        }
    }

}

final class TileView: UIView {

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        UIView.animate(withDuration: 0.5) {
            self.alpha = 1.0
        }
    }
    
    
}

