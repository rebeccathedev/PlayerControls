//
//  PlayerControlButton.swift
//  PlayerControls
//
//  Created by Rob Peck on 12/20/18.
//  Copyright © 2018 Rob Peck. All rights reserved.
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
