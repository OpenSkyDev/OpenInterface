//
//  Rect.swift
//  OpenInterface
//
//  Created by Skylar Schipper on 8/23/16.
//  Copyright © 2016 OpenSky, LLC. All rights reserved.
//

import UIKit

public extension CGRect {
    public func inset(withInsets insets: UIEdgeInsets) -> CGRect {
        return UIEdgeInsetsInsetRect(self, insets)
    }
}
