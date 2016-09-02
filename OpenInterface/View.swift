//
//  View.swift
//  OpenInterface
//
//  Created by Skylar Schipper on 8/21/16.
//  Copyright © 2016 OpenSky, LLC. All rights reserved.
//

import UIKit

public protocol AutoLayoutHelper {
    init(frame: CGRect)
    static func newAutoLayoutView() -> Self
}

extension UIView : AutoLayoutHelper {
    public static func newAutoLayoutView() -> Self {
        let view = self.init(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}
