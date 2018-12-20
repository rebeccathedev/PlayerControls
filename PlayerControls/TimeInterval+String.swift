//
//  TimeInterval+String.swift
//  PlayerControls
//
//  Created by Rebecca Peck on 12/20/18.
//  Copyright © 2018 Rebecca Peck. All rights reserved.
//

import Foundation

extension TimeInterval{
    public func string() -> String {
        
        let time = NSInteger(self)
        let seconds = time % 60
        let minutes = (time / 60) % 60
        let hours = (time / 3600)
        
        return String(format: "%0.2d:%0.2d:%0.2d",hours,minutes,seconds)
        
    }
}
