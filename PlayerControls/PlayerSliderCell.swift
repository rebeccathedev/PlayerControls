//
//  PlayerSliderCell.swift
//  PlayerControls
//
//  The MIT License (MIT)
//  
//  Copyright (c) 2018 Rebecca Peck
//  
//  Permission is hereby granted, free of charge, to any person obtaining a
//  copy of this software and associated documentation files (the "Software"),
//  to deal in the Software without restriction, including without limitation
//  the rights to use, copy, modify, merge, publish, distribute, sublicense,
//  and/or sell copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following conditions:
//  
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//  
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
//  DEALINGS IN THE SOFTWARE.
//  
//

import Foundation

class PlayerSliderCell: NSSliderCell {
    
    public var transferred: CGFloat = 0
    public var theme: PlayerControlTheme = Dark()
    
    override func drawKnob(_ knobRect: NSRect) {
        guard let ctx = NSGraphicsContext.current?.cgContext else { return }
        var newRect = knobRect
        newRect.size.width = 3
        newRect.size.height = newRect.size.height * (2/3)
        newRect.center(in: knobRect)
        
        ctx.setFillColor(self.theme.sliderKnobColor.cgColor)
        ctx.addRect(newRect)
        ctx.fillPath()
    }
    
    override func drawBar(inside rect: NSRect, flipped: Bool) {
        guard let ctx = NSGraphicsContext.current?.cgContext else { return }
        
        var fullRect = rect
        fullRect.size.height = 3
        ctx.setFillColor(self.theme.sliderBarColor.cgColor)
        ctx.setAlpha(self.theme.sliderBarAlpha)
        ctx.addRect(fullRect)
        ctx.fillPath()
        
        var completedRect = fullRect
        completedRect.size.width = fullRect.size.width * self.transferred
        ctx.setFillColor(self.theme.sliderBarDownloadColor.cgColor)
        ctx.addRect(completedRect)
        ctx.fillPath()
        
        ctx.setAlpha(1)
    }
}
