//
//  PlayerControlsDelegate.swift
//  PlayerControls
//
//  Created by Rob Peck on 12/20/18.
//  Copyright © 2018 Rob Peck. All rights reserved.
//

import Foundation

/// A delegate protocol for messages about the Player Controls.
public protocol PlayerControlDelegate {
    
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

