//
//  Constrant.swift
//  OpenInterface
//
//  Created by Skylar Schipper on 8/21/16.
//  Copyright © 2016 OpenSky, LLC. All rights reserved.
//

import UIKit

public extension NSLayoutConstraint {
    public class func offset(view: UIView, inView: UIView?, offset: CGFloat, edges: UIRectEdge) -> [NSLayoutConstraint] {
        var array: [NSLayoutConstraint] = []

        if edges.contains(.top) {
            let constraint = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: inView, attribute: .top, multiplier: 1.0, constant: offset)
            array.append(constraint)
        }

        if edges.contains(.bottom) {
            let constraint = NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: inView, attribute: .bottom, multiplier: 1.0, constant: -offset)
            array.append(constraint)
        }

        if edges.contains(.left) {
            let constraint = NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal, toItem: inView, attribute: .left, multiplier: 1.0, constant: offset)
            array.append(constraint)
        }

        if edges.contains(.right) {
            let constraint = NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal, toItem: inView, attribute: .right, multiplier: 1.0, constant: -offset)
            array.append(constraint)
        }

        return array
    }

    public class func offset(inSuperViewForView view: UIView, offset: CGFloat, edges: UIRectEdge) -> [NSLayoutConstraint] {
        return self.offset(view: view, inView: view.superview, offset: offset, edges: edges)
    }
}
