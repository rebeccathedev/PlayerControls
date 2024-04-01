//
//  PlayerControl.swift
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
import Cocoa

public class PlayerControl: NSVisualEffectView {
    
    /// Provides a delegate for messages.
    public weak var delegate: PlayerControlDelegate? = nil
    
    /// The total time of the media you are playing. This is expressed as a
    /// TimeInterval type.
    public var totalTime: TimeInterval? = nil {
        didSet {
            if totalTime! < 0 {
                self.totalTime = 0
                return
            }
            
            self.slider.maxValue = totalTime!
            self.slider.isEnabled = true
            self.remainingTimeLabel.stringValue = totalTime!.string()
        }
    }
    
    /// The current time point in the media. This is expressed as a TimeInterval
    /// type. Updating this will update labels and the slider.
    public var currentTime: TimeInterval = 0 {
        didSet {
            guard let tt = self.totalTime else { return }
            if currentTime < 0 {
                self.currentTime = 0
                return
            }
            
            if tt >= currentTime {
                self.slider.doubleValue = self.currentTime
                self.currentTimeLabel.stringValue = self.currentTime.string()
                self.remainingTimeLabel.stringValue = (tt - self.currentTime).string()
            }
        }
    }
    
    /// How far forward the Jump Forward button advances the time.
    @IBInspectable public var jumpForwardTimeInternal: TimeInterval = 15
    
    /// How far backward the Jump Backward button advances the time.
    @IBInspectable public var jumpBackwardTimeInterval: TimeInterval = 15
    
    /// If you are using download percentage in the slider, this adjusts how
    /// much you show as downloaded. Expressed as a CGFloat percentage between
    /// 0.0 and 1.0.
    public var transferred: CGFloat = 0 {
        didSet {
            if transferred < 0 {
                transferred = 0
                return
            }
            
            if transferred > 1 {
                transferred = 0
                return
            }
            
            self.slider.transferred = self.transferred
        }
    }
    
    /// If enabled, when the used mouses over the player the player is shown,
    /// and when the mouse leaves the bounds the player is hidden.
    @IBInspectable public var hideOnMouseOut: Bool = true {
        didSet {
            self.layoutControl()
        }
    }
    
    /// If true (and hideOnMouseOut is true) shows the player initially, then
    /// hides it after this TimeInterval.
    public var hideAfter: TimeInterval = 5 {
        didSet {
            self.layoutControl()
        }
    }
    
    /// Sets how hidden the control is when it is hidden. Expressed as a float
    /// between 0 and 1.
    public var hiddenAlphaValue: CGFloat = 0 {
        didSet {
            self.layoutControl()
            if isHidden {
                self.animator().alphaValue = hiddenAlphaValue
            }
        }
    }
    
    /// Sets how visible the control is when it is visible. Expressed as a float
    /// between 0 and 1.
    public var visibleAlphaValue: CGFloat = 1 {
        didSet {
            self.layoutControl()
            if !isHidden {
                self.animator().alphaValue = visibleAlphaValue
            }
        }
    }
    
    /// The status of the control (playing or paused)
    public var status: Status = .paused {
        didSet {
            self.playButton.state = self.status == .paused ? .off : .on
        }
    }
    
    /// Sets the theme. It is an instance of PlayerControlTheme.
    public var theme: PlayerControlTheme = Dark() {
        didSet {
            self.layoutControl()
        }
    }
    
    /// We override the isHidden property to use alpha values to control the
    /// visiblity of the control.
    public override var isHidden: Bool {
        set {
            _isHidden = newValue
            if _isHidden {
                self.animator().alphaValue = self.hiddenAlphaValue
            } else {
                self.animator().alphaValue = self.visibleAlphaValue
            }
        }
        get {
            return _isHidden
        }
    }
    
    /// Private var to control our actual hidden status.
    private var _isHidden: Bool = false;
    
    /// The size of icons to use. This should be set to the largest possible
    /// size that will be used on your play/pause button. It will be
    /// automatically scaled down for your smaller buttons.
    @IBInspectable public var iconSize = NSSize(width: 100, height: 100)
    
    /// Whether the Rewind button is visible.
    @IBInspectable public var showRewindButton: Bool = true {
        didSet {
            self.layoutControl()
        }
    }
    
    /// Whether the Fast Forward button is visible.
    @IBInspectable public var showFastForwardButton: Bool = true {
        didSet {
            self.layoutControl()
        }
    }
    
    /// Whether the Jump Back button is visible.
    @IBInspectable public var showJumpBackButton: Bool = true {
        didSet {
            self.layoutControl()
        }
    }
    
    /// Whether the Jump Forward button is visible.
    @IBInspectable public var showJumpForwardButton: Bool = true {
        didSet {
            self.layoutControl()
        }
    }
    
    /// Whether the time labels are visible.
    @IBInspectable public var showLabels: Bool = true {
        didSet {
            self.layoutControl()
        }
    }
    
    /// The image used on the Rewind button.
    @IBInspectable public var rewindbuttonImage: NSImage? {
        didSet {
            self.layoutControl()
        }
    }
    
    /// The image used on the Fast Forward button.
    @IBInspectable public var fastForwardButtonImage: NSImage? {
        didSet {
            self.layoutControl()
        }
    }
    
    /// The image used on the Jump Back button.
    @IBInspectable public var jumpBackButtonImage: NSImage? {
        didSet {
            self.layoutControl()
        }
    }
    
    /// The image used on the Jump Forward button.
    @IBInspectable public var jumpForwardButtonImage: NSImage? {
        didSet {
            self.layoutControl()
        }
    }
    
    /// The image used on the Play button.
    @IBInspectable public var playButtonImage: NSImage? {
        didSet {
            self.layoutControl()
        }
    }
    
    /// The image used on the Pause button. From a technical standpoint, Play
    /// and Pause are the same button, and the image is swapped depending on the
    /// state.
    @IBInspectable public var pauseButtonImage: NSImage? {
        didSet {
            self.layoutControl()
        }
    }
    
    /// An enum that holds our playing statuses.
    ///
    /// - playing: Playing (the alt image on the play button is used)
    /// - paused: Paused (the main image on the play button is used)
    public enum Status {
        case playing
        case paused
    }
    
    /// The instance of the slider.
    private var slider: PlayerSlider = PlayerSlider()
    
    /// The instance of the remaining time label.
    private var remainingTimeLabel: PlayerLabel = PlayerLabel()
    
    /// The instance of the current time label.
    private var currentTimeLabel: PlayerLabel = PlayerLabel()
    
    /// The instance of the play/pause button.
    private var playButton: PlayerControlButton = PlayerControlButton()
    
    /// The instance of the rewind button.
    private var rewindButton: PlayerControlButton = PlayerControlButton()
    
    /// The instance of the fast forward button.
    private var fastForwardButton: PlayerControlButton = PlayerControlButton()
    
    /// The instance of the jump backward button.
    private var jumpBackButton: PlayerControlButton = PlayerControlButton()
    
    /// The instance of the jum forward button.
    private var jumpForwardButton: PlayerControlButton = PlayerControlButton()
    
    /// Convenience var to determine if any upper controls are visible.
    private var areAnyButtonsVisible: Bool {
        get {
            return self.showLabels ||
                self.showRewindButton ||
                self.showJumpBackButton ||
                self.showFastForwardButton ||
                self.showJumpForwardButton
        }
    }
    
    /// The main stack is the vertical stack, with controls on top and slider on
    /// bottom.
    private var mainStack: NSStackView = NSStackView()
    
    /// The control stack is the horizontal stack above the slider.
    private var controlStack: NSStackView = NSStackView()
    
    /// Holds the timer that delays hiding.
    private var hideTimer: Timer? = nil
    
    /// Sets up the control
    override public func awakeFromNib() {
        self.wantsLayer = true
        self.layer?.cornerRadius = 5
        self.layer?.masksToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.postsFrameChangedNotifications = true
        
        self.addSubviewConstraints()
        self.setupStacks()
        self.layoutControl()
    }
    
    func addSubviewConstraints() {
        self.addSubview(self.playButton)
        self.addConstraints([
            .init(item: self.playButton, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 5),
            .init(item: self, attribute: .bottom, relatedBy: .equal, toItem: self.playButton, attribute: .bottom, multiplier: 1, constant: 5),
            .init(item: self.playButton, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 5),
            .init(item: self.playButton, attribute: .width, relatedBy: .equal, toItem: self.playButton, attribute: .height, multiplier: 1, constant: 0)
            ])
        
        self.addSubview(mainStack)
        self.addConstraints([
            .init(item: mainStack, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 5),
            .init(item: self, attribute: .bottom, relatedBy: .equal, toItem: mainStack, attribute: .bottom, multiplier: 1, constant: 5),
            .init(item: mainStack, attribute: .left, relatedBy: .equal, toItem: self.playButton, attribute: .right, multiplier: 1, constant: 5),
            .init(item: self, attribute: .right, relatedBy: .equal, toItem: mainStack, attribute: .right, multiplier: 1, constant: 5)
            ])
    }
    
    func layoutControl() {
        setupPlayButton()
        setupSlider()
        setupJumpButtons()
        setupLabels()
        setupControlInStacks()
        setTheme()
        setHiding()
    }
    
    override public func mouseEntered(with event: NSEvent) {
        self.isHidden = false
    }
    
    override public func mouseExited(with event: NSEvent) {
        self.isHidden = true
    }
    
    func setupPlayButton() {
        self.playButton.theme = self.theme
        self.playButton.action = #selector(self.playButtonClicked)
        self.playButton.target = self
        self.playButton.setButtonType(.pushOnPushOff)
        self.playButton.translatesAutoresizingMaskIntoConstraints = false
        self.playButton.image = self.playButtonImage
        self.playButton.alternateImage = self.pauseButtonImage
    }
    
    func setupSlider() {
        self.slider.target = self
        self.slider.action = #selector(self.sliderChanged)
        self.slider.isEnabled = false
        self.slider.sliderType = .linear
        self.slider.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupJumpButtons() {
        setupButton(button: jumpBackButton, image: jumpBackButtonImage)
        setupButton(button: jumpForwardButton, image: jumpForwardButtonImage)
        setupButton(button: fastForwardButton, image: fastForwardButtonImage)
        setupButton(button: rewindButton, image: rewindbuttonImage)
    }
    
    func setupLabels() {
        setupLabel(label: currentTimeLabel)
        setupLabel(label: remainingTimeLabel)
    }
    
    func setupStacks() {
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.orientation = .vertical
        mainStack.alignment = .centerX
        mainStack.distribution = .equalCentering
        mainStack.spacing = 5
        
        controlStack.orientation = .horizontal
        controlStack.alignment = .centerY
        controlStack.distribution = .fill
        controlStack.spacing = 5
        
        mainStack.addArrangedSubview(controlStack)
        mainStack.addArrangedSubview(self.slider)
        
        let spacerView = NSView()
        spacerView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        controlStack.addArrangedSubview(self.rewindButton)
        controlStack.addArrangedSubview(self.jumpBackButton)
        controlStack.addArrangedSubview(self.currentTimeLabel)
        controlStack.addArrangedSubview(spacerView)
        controlStack.addArrangedSubview(self.remainingTimeLabel)
        controlStack.addArrangedSubview(self.jumpForwardButton)
        controlStack.addArrangedSubview(self.fastForwardButton)
    }
    
    func setupControlInStacks() {
        if self.areAnyButtonsVisible {
            self.controlStack.isHidden = false
            
            self.rewindButton.isHidden = !showRewindButton
            self.jumpBackButton.isHidden = !showJumpBackButton
            self.remainingTimeLabel.isHidden = !showLabels
            self.currentTimeLabel.isHidden = !showLabels
            self.jumpForwardButton.isHidden = !showJumpForwardButton
            self.fastForwardButton.isHidden = !showFastForwardButton
        } else {
            controlStack.isHidden = true
        }
    }
    
    func setTheme() {
        self.blendingMode = self.theme.blendingMode
        self.material = self.theme.material
        self.playButton.theme = self.theme
        self.rewindButton.theme = self.theme
        self.fastForwardButton.theme = self.theme
        self.jumpBackButton.theme = self.theme
        self.jumpForwardButton.theme = self.theme
        self.slider.theme = self.theme
        self.currentTimeLabel.theme = self.theme
        self.remainingTimeLabel.theme = self.theme
    }
    
    func setHiding() {
        self.animator().alphaValue = self.visibleAlphaValue
        NotificationCenter.default.removeObserver(self, name: NSView.frameDidChangeNotification, object: nil)
        
        if self.hideOnMouseOut {
            self.setTrackingArea()
            NotificationCenter.default.addObserver(forName: NSView.frameDidChangeNotification, object: self, queue: nil) { (notificiation) in
                self.setTrackingArea()
            }
            
            if self.hideAfter > 0 {
                self.hideTimer = Timer.scheduledTimer(withTimeInterval: self.hideAfter, repeats: false) { timer in
                    self.isHidden = true
                }
            }
        } else {
            self.hideTimer?.invalidate()
            for tracking in self.trackingAreas {
                self.removeTrackingArea(tracking)
            }
        }
    }
    
    public func setTrackingArea() {
        for tracking in self.trackingAreas {
            self.removeTrackingArea(tracking)
        }
        
        let options: NSTrackingArea.Options = [.mouseEnteredAndExited, .activeAlways]
        let trackingArea = NSTrackingArea(rect: self.bounds, options: options, owner: self, userInfo: nil)
        self.addTrackingArea(trackingArea)
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
            
            if sender == self.fastForwardButton {
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

    private func setupButton(button: PlayerControlButton, image: NSImage?) {
        button.theme = self.theme
        button.target = self
        button.action = #selector(jump)
        button.image = image
        
        self.addConstraints([
            .init(item: button, attribute: .width, relatedBy: .equal, toItem: self.playButton, attribute: .width, multiplier: 0.5, constant: 0),
            .init(item: button, attribute: .width, relatedBy: .equal, toItem: button, attribute: .height, multiplier: 1, constant: 0)
            ])
    }

    private func setupLabel(label: PlayerLabel) {
        label.isEditable = false
        label.stringValue = "00:00:00"
        label.textColor = .white
        label.isBezeled = false
        label.drawsBackground = false
    }
}
