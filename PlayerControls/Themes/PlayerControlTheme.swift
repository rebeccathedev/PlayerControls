//
//  PlayerControlTheme.swift
//  PlayerControls
//
//  Created by Rob Peck on 12/20/18.
//  Copyright © 2018 Rob Peck. All rights reserved.
//

import Foundation
import Cocoa

public protocol PlayerControlTheme {
    var blendingMode: NSVisualEffectView.BlendingMode { get }
    var material: NSVisualEffectView.Material { get }
    var buttonColor: NSColor { get }
    var buttonAlpha: CGFloat { get }
    var labelTextColor: NSColor { get }
    var sliderKnobColor: NSColor { get }
    var sliderBarColor: NSColor { get }
    var sliderBarDownloadColor: NSColor { get }
    var sliderBarAlpha: CGFloat { get }
}
