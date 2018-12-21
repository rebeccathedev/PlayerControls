//
//  PlayerSlider.swift
//  PlayerControls
//
//  Created by Rob Peck on 12/20/18.
//  Copyright © 2018 Rob Peck. All rights reserved.
//

import Foundation


class PlayerSlider: NSSlider {
    public var transferred: CGFloat = 0 {
        didSet {
            guard let cl = self.cell as? PlayerSliderCell else { return }
            cl.transferred = self.transferred
            self.needsDisplay = true
        }
    }
    
    public var theme: PlayerControlTheme = Dark() {
        didSet {
            guard let cl = self.cell as? PlayerSliderCell else { return }
            cl.theme  = self.theme
            self.needsDisplay = true
        }
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.cell = PlayerSliderCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.cell = PlayerSliderCell()
    }
}
