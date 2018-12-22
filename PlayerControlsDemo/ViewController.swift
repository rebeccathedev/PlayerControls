//
//  ViewController.swift
//  PlayerControlsDemo
//
//  Created by Rob Peck on 12/20/18.
//  Copyright © 2018 Rob Peck. All rights reserved.
//

import Cocoa
import PlayerControls

class ViewController: NSViewController {
    
    @objc var viewBackgroundColor: NSColor = .black {
        didSet {
            self.containerLayer.layer?.backgroundColor = self.viewBackgroundColor.cgColor
        }
    }
    
    @objc var tranferred: CGFloat = 0 {
        didSet {
            self.playerControl.transferred = self.tranferred / 100
        }
    }
    
    @objc var totalTime: NSNumber = 0 {
        didSet {
            self.playerControl.totalTime = totalTime.doubleValue
        }
    }
    
    @objc var currentTime: NSNumber = 0 {
        didSet {
            self.playerControl.currentTime = currentTime.doubleValue
        }
    }

    @IBOutlet weak var containerLayer: NSView!
    @IBOutlet weak var playerControl: PlayerControl!
    @IBOutlet weak var actionLabel: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.containerLayer.wantsLayer = true
        self.containerLayer.layer?.backgroundColor = self.viewBackgroundColor.cgColor
        self.playerControl.delegate = self
    }
    
    @IBAction func themeChanged(_ sender: Any?) {
        if let button = sender as? NSPopUpButton {
            if button.selectedTag() == 0 {
                self.playerControl.theme = Dark()
            } else {
                self.playerControl.theme = Light()
            }
        }
    }
}

extension ViewController: PlayerControlDelegate {
    func statusChanged(_ playerControl: PlayerControl, status: PlayerControl.Status) {
        var playerStatusString = ""
        switch status {
        case .playing:
            playerStatusString = "playing"
        case .paused:
            playerStatusString = "paused"
        }
        
        self.actionLabel.stringValue = "statusChanged " + playerStatusString
    }
    
    func timeChanged(_ playerControl: PlayerControl, time: TimeInterval) {
        self.actionLabel.stringValue = "timeChanged " + String(time)
    }
    
    
}
