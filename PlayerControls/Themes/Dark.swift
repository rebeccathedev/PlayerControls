//
//  Dark.swift
//  PlayerControls
//
//  Created by Rebecca Peck on 12/20/18.
//  Copyright © 2018 Rebecca Peck. All rights reserved.
//

import Foundation

public struct Dark: PlayerControlTheme {
    public var blendingMode: NSVisualEffectView.BlendingMode = .withinWindow
    
    public var material: NSVisualEffectView.Material = .dark
    
    public var buttonColor: NSColor = .black
    
    public var buttonAlpha: CGFloat = 0.5
    
    public var labelTextColor: NSColor = .white
    
    public var sliderKnobColor: NSColor = .gray
    
    public var sliderBarColor: NSColor = .black
    
    public var sliderBarDownloadColor: NSColor = .white
    
    public var sliderBarAlpha: CGFloat = 0.5
}
