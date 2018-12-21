//
//  PlayerLabel.swift
//  PlayerControls
//
//  Created by Rebecca Peck on 12/20/18.
//  Copyright © 2018 Rebecca Peck. All rights reserved.
//

import Cocoa

class PlayerLabel: NSTextField {
    public var theme: PlayerControlTheme = Dark() {
        didSet {
            self.textColor = self.theme.labelTextColor
            self.setNeedsDisplay()
        }
    }
}
