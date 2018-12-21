//
//  PlayerControls.swift
//  PlayerControls
//
//  Created by Rob Peck on 12/20/18.
//  Copyright © 2018 Rob Peck. All rights reserved.
//

import Foundation
import Cocoa

public class PlayerControl: NSVisualEffectView {
    
    /// Provides a delegate for messages.
    public var delegate: PlayerControlDelegate? = nil
    
    /// The total time of the media you are playing. This is expressed
    /// as a TimeInterval type.
    public var totalTime: TimeInterval? = nil {
        didSet {
            self.slider?.maxValue = self.totalTime!
            self.slider?.isEnabled = true
        }
    }
    
    /// The current time point in the media. This is expressed as a
    /// TimeInterval type. Updating this will update labels and the
    /// slider.
    public var currentTime: TimeInterval = 0 {
        didSet {
            self.slider?.doubleValue = self.currentTime
            self.currentTimeLabel.stringValue = self.currentTime.string()
            self.remainingTimeLabel.stringValue = (self.totalTime! - self.currentTime).string()
        }
    }
    
    /// How far forward the Jump Forward button advances the time.
    @IBInspectable public var jumpForwardTimeInternal: TimeInterval = 15
    
    /// How far backward the Jump Backward button advances the time.
    @IBInspectable public var jumpBackwardTimeInterval: TimeInterval = 15
    
    /// If you are using download percentage in the slider, this
    /// adjusts how much you show as downloaded. Expressed as a
    /// CGFloat percentage between 0.0 and 1.0.
    public var transferred: CGFloat = 0 {
        didSet {
            self.slider.transferred = self.transferred
        }
    }
    
    /// If enabled, when the used mouses over the player the player
    /// is shown, and when the mouse leaves the bounds the player is
    /// hidden.
    @IBInspectable public var hideOnMouseOut: Bool = true
    
    /// If true (and hideOnMouseOut is true) shows the player
    /// initially, then hides it after this TimeInterval.
    @IBInspectable public var hideAfter: TimeInterval = 5
    
    /// The status of the control (playing or paused)
    public var status: Status = .paused {
        didSet {
            self.playButton.state = self.status == .paused ? .off : .on
        }
    }
    
    public var theme: PlayerControlTheme = Dark() {
        didSet {
            self.setTheme()
        }
    }
    
    @IBInspectable public var iconSize = CGSize(width: 100, height: 100)
    
    @IBInspectable public var showRewindButton: Bool = true
    @IBInspectable public var showFastForwardButton: Bool = true
    @IBInspectable public var showJumpBackButton: Bool = true
    @IBInspectable public var showForwardButton: Bool = true
    @IBInspectable public var showLabels: Bool = true
    
    @IBInspectable public var rewindbuttonImage: NSImage?
    @IBInspectable public var fastForwardButtonImage: NSImage?
    @IBInspectable public var jumpBackButtonImage: NSImage?
    @IBInspectable public var jumpForwardButtonImage: NSImage?
    @IBInspectable public var playButtonImage: NSImage?
    @IBInspectable public var pauseButtonImage: NSImage?
    
    /// An enum that holds our playing statuses.
    ///
    /// - playing: Playing (the alt image on the play button is used)
    /// - paused: Paused (the main image on the play button is used)
    public enum Status {
        case playing
        case paused
    }
    
    private var slider: PlayerSlider!
    private var remainingTimeLabel: PlayerLabel!
    private var currentTimeLabel: PlayerLabel!
    
    private var playButton: PlayerControlButton!
    private var rewindButton: PlayerControlButton!
    private var fastFowardButton: PlayerControlButton!
    private var jumpBackButton: PlayerControlButton!
    private var jumpForwardButton: PlayerControlButton!
    
    /// Sets up the control
    override public func awakeFromNib() {
        self.wantsLayer = true
        self.layer?.cornerRadius = 5
        self.layer?.masksToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.postsFrameChangedNotifications = true
        
        self.createPlayButton()
        self.createSlider()
        self.createJumpButtons()
        self.createLabels()
        self.createStacks()
        self.setTheme()
        
        NotificationCenter.default.addObserver(forName: NSView.frameDidChangeNotification, object: self, queue: nil) { (notificiation) in
            for tracking in self.trackingAreas {
                self.removeTrackingArea(tracking)
            }
            
            let options: NSTrackingArea.Options = [.mouseEnteredAndExited, .activeAlways]
            let trackingArea = NSTrackingArea(rect: self.bounds, options: options, owner: self, userInfo: nil)
            self.addTrackingArea(trackingArea)
        }
    }
    
    override public func mouseEntered(with event: NSEvent) {
        self.animator().alphaValue = 1
    }
    
    override public func mouseExited(with event: NSEvent) {
        self.animator().alphaValue = 0
    }
    
    func createPlayButton() {
        self.playButton = PlayerControlButton()
        self.playButton.theme = self.theme
        self.playButton.action = #selector(self.playButtonClicked)
        self.playButton.target = self
        self.playButton.setButtonType(.pushOnPushOff)
        self.playButton.translatesAutoresizingMaskIntoConstraints = false
        self.playButton.image = self.playButtonImage
        self.playButton.alternateImage = self.pauseButtonImage
        self.addSubview(self.playButton)
        
        self.addConstraints([
            .init(item: self.playButton, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 5),
            .init(item: self, attribute: .bottom, relatedBy: .equal, toItem: self.playButton, attribute: .bottom, multiplier: 1, constant: 5),
            .init(item: self.playButton, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 5),
            .init(item: self.playButton, attribute: .width, relatedBy: .equal, toItem: self.playButton, attribute: .height, multiplier: 1, constant: 0)
            ])
    }
    
    func createSlider() {
        self.slider = PlayerSlider()
        self.slider.target = self
        self.slider.action = #selector(self.sliderChanged)
        self.slider.isEnabled = false
        self.slider.sliderType = .linear
        self.slider.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func createJumpButtons() {
        func createButton(image: NSImage?) -> PlayerControlButton {
            let button = PlayerControlButton()
            button.theme = self.theme
            button.target = self
            button.action = #selector(jump)
            button.image = image
            
            self.addConstraints([
                .init(item: button, attribute: .width, relatedBy: .equal, toItem: self.playButton, attribute: .width, multiplier: 0.5, constant: 0),
                .init(item: button, attribute: .width, relatedBy: .equal, toItem: button, attribute: .height, multiplier: 1, constant: 0)
                ])
            
            return button
        }
        
        self.jumpBackButton = createButton(image: self.jumpBackButtonImage)
        self.jumpForwardButton = createButton(image: self.jumpForwardButtonImage)
        self.fastFowardButton = createButton(image: self.fastForwardButtonImage)
        self.rewindButton = createButton(image: self.rewindbuttonImage)
    }
    
    func createLabels() {
        func createLabel() -> PlayerLabel {
            let obj = PlayerLabel()
            obj.isEditable = false
            obj.stringValue = "00:00:00"
            obj.textColor = .white
            obj.isBezeled = false
            obj.drawsBackground = false
            
            return obj
        }
        
        self.currentTimeLabel = createLabel()
        self.remainingTimeLabel = createLabel()
    }
    
    func createStacks() {
        let stack = NSStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.orientation = .vertical
        stack.alignment = .centerX
        stack.distribution = .equalCentering
        stack.spacing = 5
        self.addSubview(stack)
        self.addConstraints([
            .init(item: stack, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 5),
            .init(item: self, attribute: .bottom, relatedBy: .equal, toItem: stack, attribute: .bottom, multiplier: 1, constant: 5),
            .init(item: stack, attribute: .left, relatedBy: .equal, toItem: self.playButton, attribute: .right, multiplier: 1, constant: 5),
            .init(item: self, attribute: .right, relatedBy: .equal, toItem: stack, attribute: .right, multiplier: 1, constant: 5)
            ])
        
        let controlStack = NSStackView()
        controlStack.orientation = .horizontal
        controlStack.alignment = .centerY
        controlStack.distribution = .fill
        controlStack.spacing = 5
        
        stack.addArrangedSubview(controlStack)
        stack.addArrangedSubview(self.slider)
        
        let spacerView = NSView()
        spacerView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        controlStack.addArrangedSubview(self.rewindButton)
        controlStack.addArrangedSubview(self.jumpBackButton)
        controlStack.addArrangedSubview(self.currentTimeLabel)
        controlStack.addArrangedSubview(spacerView)
        controlStack.addArrangedSubview(self.remainingTimeLabel)
        controlStack.addArrangedSubview(self.jumpForwardButton)
        controlStack.addArrangedSubview(self.fastFowardButton)
    }
    
    func setTheme() {
        self.blendingMode = self.theme.blendingMode
        self.material = self.theme.material
        self.playButton.theme = self.theme
        self.rewindButton.theme = self.theme
        self.fastFowardButton.theme = self.theme
        self.jumpBackButton.theme = self.theme
        self.jumpForwardButton.theme = self.theme
        self.slider.theme = self.theme
        self.currentTimeLabel.theme = self.theme
        self.remainingTimeLabel.theme = self.theme
        
    }
    
    @objc func playButtonClicked() {
        self.status = self.playButton.state == .on ? .playing : .paused
        self.delegate?.statusChanged(self, status: self.status)
    }
    
    @objc func sliderChanged() {
        self.currentTime = self.slider.doubleValue
        self.delegate?.timeChanged(self, time: self.currentTime)
    }
    
    @objc func jump(_ sender: PlayerControlButton) {
        if let tt = self.totalTime {
            if sender == self.jumpBackButton {
                self.currentTime = self.currentTime - self.jumpBackwardTimeInterval
            }
            
            if sender == self.jumpForwardButton {
                self.currentTime = self.currentTime + self.jumpForwardTimeInternal
            }
            
            if sender == self.fastFowardButton {
                self.currentTime = tt
            }
            
            if sender == self.rewindButton {
                self.currentTime = 0
            }
            
            if self.currentTime < 0 {
                self.currentTime = 0
            }
            
            if self.currentTime > self.totalTime! {
                self.currentTime = self.totalTime!
            }
            
            self.delegate?.timeChanged(self, time: self.currentTime)
        }
    }
}
