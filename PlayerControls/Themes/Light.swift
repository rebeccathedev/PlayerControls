//
//  Light.swift
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
