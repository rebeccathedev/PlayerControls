//
//  ViewController.swift
//  PlayerControlsDemo
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

import Cocoa
import PlayerControls
import UniformTypeIdentifiers

@MainActor
@objc class ViewController: NSViewController {
    
    @objc var viewBackgroundColor: NSColor = .black {
        didSet {
            self.containerLayer.layer?.backgroundColor = self.viewBackgroundColor.cgColor
        }
    }
    
    @objc var transferred: CGFloat = 0 {
        didSet {
            self.playerControl.transferred = self.transferred / 100
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
    
    @objc var hiddenAlphaValue: CGFloat = 0 {
        didSet {
            self.playerControl.hiddenAlphaValue = self.hiddenAlphaValue
        }
    }
    
    @objc var visibleAlphaValue: CGFloat = 1 {
        didSet {
            self.playerControl.visibleAlphaValue = self.visibleAlphaValue
        }
    }
    
    @objc var hideOnMouseOut: Bool = true {
        didSet {
            self.playerControl.hideOnMouseOut = self.hideOnMouseOut
        }
    }

    @objc var showLabels: Bool = true {
        didSet {
            self.playerControl.showLabels = self.showLabels
        }
    }

    @objc var showRewindButton: Bool = true {
        didSet {
            self.playerControl.showRewindButton = self.showRewindButton
        }
    }

    @objc var showFastForwardButton: Bool = true {
        didSet {
            self.playerControl.showFastForwardButton = self.showFastForwardButton
        }
    }

    @objc var showJumpBackButton: Bool = true {
        didSet {
            self.playerControl.showJumpBackButton = self.showJumpBackButton
        }
    }

    @objc var showJumpForwardButton: Bool = true {
        didSet {
            self.playerControl.showJumpForwardButton = self.showJumpForwardButton
        }
    }

    @IBOutlet weak var containerLayer: NSView!
    @IBOutlet weak var playerControl: PlayerControl!
    @IBOutlet weak var actionLabel: NSTextField!
    @IBOutlet weak var backgroundLabel: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.containerLayer.wantsLayer = true
        self.containerLayer.layer?.backgroundColor = self.viewBackgroundColor.cgColor
        
        self.playerControl.delegate = self
        self.playerControl.playButtonImage = NSImage(named: .play)?.imageWithTintColor(tint: .gray)
        self.playerControl.pauseButtonImage = NSImage(named: .pause)?.imageWithTintColor(tint: .gray)
        self.playerControl.jumpForwardButtonImage = NSImage(named: .ff)?.imageWithTintColor(tint: .gray)
        self.playerControl.fastForwardButtonImage = NSImage(named: .end)?.imageWithTintColor(tint: .gray)
        self.playerControl.jumpBackButtonImage = NSImage(named: .rewind)?.imageWithTintColor(tint: .gray)
        self.playerControl.rewindbuttonImage = NSImage(named: .beginning)?.imageWithTintColor(tint: .gray)
    }
    
    override nonisolated func setNilValueForKey(_ key: String) {
        // Here to prevent an error with bindings.
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
    
    @IBAction func openFile(_ sender: Any?) {
        let openPanel = NSOpenPanel()
        openPanel.allowsMultipleSelection = false
        openPanel.canChooseDirectories = false
        openPanel.canCreateDirectories = false
        openPanel.canChooseFiles = true
        openPanel.allowedContentTypes = [.jpeg]
        
        openPanel.begin { [weak self] result in
            guard let self, result == .OK, let url = openPanel.url else {
                return
            }
            
            self.containerLayer.layer?.contents = NSImage(contentsOf: url)
            self.backgroundLabel.stringValue = url.absoluteString
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
