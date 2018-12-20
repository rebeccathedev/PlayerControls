//
//  NSRect+Center.swift
//  PlayerControls
//
//  Created by Rob Peck on 12/20/18.
//  Copyright © 2018 Rob Peck. All rights reserved.
//

import Foundation
import Cocoa

extension NSRect {
    public mutating func center(in outerRect: NSRect) {
        self.origin.x = outerRect.midX - self.size.width / 2
        self.origin.y = outerRect.midY - self.size.height / 2
    }
}
