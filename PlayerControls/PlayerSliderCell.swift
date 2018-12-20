//
//  PlayerSliderCell.swift
//  PlayerControls
//
//  Created by Rob Peck on 12/20/18.
//  Copyright © 2018 Rob Peck. All rights reserved.
//

import Foundation

class PlayerSliderCell: NSSliderCell {
    
    override func drawKnob(_ knobRect: NSRect) {
        guard let ctx = NSGraphicsContext.current?.cgContext else { return }
        var newRect = knobRect
        newRect.size.width = 3
        newRect.size.height = newRect.size.height * (2/3)
        newRect.center(in: knobRect)
        
        ctx.setFillColor(NSColor.gray.cgColor)
        ctx.addRect(newRect)
        ctx.fillPath()
    }
    
    override func drawBar(inside rect: NSRect, flipped: Bool) {
        guard let ctx = NSGraphicsContext.current?.cgContext else { return }
        
        var fullRect = rect
        fullRect.size.height = 3
        ctx.setFillColor(NSColor.black.cgColor)
        ctx.setAlpha(0.5)
        ctx.addRect(fullRect)
        ctx.fillPath()
        
        var completedRect = fullRect
        completedRect.size.width = fullRect.size.width * CGFloat(self.floatValue)
        ctx.setFillColor(NSColor.white.cgColor)
        ctx.addRect(completedRect)
        ctx.fillPath()
        
        ctx.setAlpha(1)
    }
}
