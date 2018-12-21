//
//  Light.swift
//  PlayerControls
//
//  Created by Rebecca Peck on 12/20/18.
//  Copyright © 2018 Rebecca Peck. All rights reserved.
//

import Foundation

public struct Light: PlayerControlTheme {
    public var blendingMode: NSVisualEffectView.BlendingMode = .withinWindow
    
    public var material: NSVisualEffectView.Material = .light
    
    public var buttonColor: NSColor = .white
    
    public var buttonAlpha: CGFloat = 0.5
    
    public var labelTextColor: NSColor = .white
    
    public var sliderKnobColor: NSColor = .lightGray
    
    public var sliderBarColor: NSColor = .gray
    
    public var sliderBarDownloadColor: NSColor = .white
    
    public var sliderBarAlpha: CGFloat = 0.5
    
    public init() {}
}
