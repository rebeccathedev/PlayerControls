//
//  PlayerSlider.swift
//  PlayerControls
//
//  Created by Rob Peck on 12/20/18.
//  Copyright © 2018 Rob Peck. All rights reserved.
//

import Foundation


class PlayerSlider: NSSlider {
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.cell = PlayerSliderCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.cell = PlayerSliderCell()
    }
}
