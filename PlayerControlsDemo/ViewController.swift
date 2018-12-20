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

    @IBOutlet weak var containerLayer: NSView!
    @IBOutlet weak var playerControl: PlayerControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.containerLayer.wantsLayer = true
        self.containerLayer.layer?.backgroundColor = self.viewBackgroundColor.cgColor

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

