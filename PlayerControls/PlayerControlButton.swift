//
//  PlayerControlButton.swift
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
import Cocoa

class PlayerControlButton: NSButton {
    var theme: PlayerControlTheme = Dark() {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    override var focusRingType: NSFocusRingType {
        get {
            return .none
        }
        set {}
    }
    
    override func draw(_ dirtyRect: NSRect) {
        guard let ctx = NSGraphicsContext.current?.cgContext else { return }
        
        // Create a rounded rect and fill it.
        let path = NSBezierPath(roundedRect: dirtyRect, xRadius: 5, yRadius: 5)
        ctx.setFillColor(self.theme.buttonColor.cgColor)
        ctx.setAlpha(self.theme.buttonAlpha)
        ctx.addPath(path.cgPath)
        ctx.fillPath()
        
        var iconRect = dirtyRect
        iconRect.size.width = dirtyRect.size.width * (2/3)
        iconRect.size.height = dirtyRect.size.height * (2/3)
        iconRect.center(in: dirtyRect)
        
        var drawImage: NSImage? = self.image
        if let img = self.alternateImage, self.state == .on {
            drawImage = img
        }
        
        if let img = drawImage {
            let priorNsgc = NSGraphicsContext.current
            defer { NSGraphicsContext.current = priorNsgc }
            NSGraphicsContext.current = NSGraphicsContext(cgContext: ctx, flipped: false)
            img.draw(in: iconRect)
        }
    }
}
