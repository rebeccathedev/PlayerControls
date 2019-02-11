//
//  PlayerControlsDelegate.swift
//  PlayerControls
//
//  The MIT License (MIT)
//  
//  Copyright (c) 2018 Rob Peck
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

/// A delegate protocol for messages about the Player Controls.
public protocol PlayerControlDelegate: class {
    
    /// Delegate message sent when the player control status changes.
    ///
    /// - Parameters:
    ///   - playerControl: an instance of PlayerControls
    ///   - status: the PlayerControls.Status it changed to.
    func statusChanged(_ playerControl: PlayerControl, status: PlayerControl.Status)
    
    
    /// Delegate method sent when the player time changes. For
    /// instanc when the user uses the slider or the jump buttons.
    ///
    /// - Parameters:
    ///   - playerControl: an instance of PlayerControls
    ///   - time: The new time.
    func timeChanged(_ playerControl: PlayerControl, time: TimeInterval)
}

