# PlayerControls

PlayerControls is a macOS Cocoa framework that creates a View containing 
playback controls for media like videos or sounds. It is written in pure Swift 
4 and has no dependencies.

![control](https://raw.githubusercontent.com/peckrob/PlayerControls/master/Screenshots/control.png)

## Why?

Primarily, this is written to work with `VLCKit` which provides a media player
playback mechanism with no controls. But it does not rely on `VLCKit` and is 
suitably generic to be useful in many situations.

## Features
* Extends NSVisualEffectView for a nice blurred effect when overlaying a video.
* Eminently customizable. Almost all controls can be hidden and icons 
  customized.
* Implements a simple delegate protocol to respond to events.
* AutoLayout aware, responds nicely to resizing.
* Provides theme support. A Light and Dark theme are included, and creating your
  own is trivial.

## Installation

Add to your `Cartfile`:

```
github "peckrob/PlayerControls"
```

Alternatively, download the source, build the framework and drag the product
into your project.

## Demo

A demonstration app is available in the source code. To use it, download the 
source, open in Xcode, set the Scheme to PlayerControlsDemo and build. It will
build the framework as a dependency.

Icons used in the demo are made by [Freepik](https://www.freepik.com/) from 
[www.flaticon.com](https://www.flaticon.com/) and licensed by 
[CC 3.0 BY](http://creativecommons.org/licenses/by/3.0/).

![control](https://raw.githubusercontent.com/peckrob/PlayerControls/master/Screenshots/demoapp.png)

## Usage

Import the framework.

```swift
import PlayerControls
```

In your Storyboard file, create an `NSView` (Custom View) instance and set it's
class to `PlayerControl`. This will create your PlayerControl instance. 
Natively it doesn't look like much. You'll need to provide some customizations.

To programatically use `PlayerControl`, you can do this:

```swift
let playerControl = PlayerControl()
```

### Customizing PlayerControls

You can customize the following properties on the `PlayerControl` class to
change it's behavior or appearance.

#### Required

The following two properties are **required** and not setting them will 
basically cause the control to be non-functional.

```swift
public var totalTime: TimeInterval? = nil
```

The total length of the media you are playing.

```swift
public var currentTime: TimeInterval = 0
```

The current playback time. This starts out as zero and should be updated by your
calling code. When you are using `VLCKit`, this should be updated from your 
`VLCMediaPlayerDelegate`'s `mediaPlayerTimeChanged` function. This will also be
updated by the control itself (when the user does something to change the 
current time), and a callback will be called (see "Responding to Events" below.)

#### Optional

```swift
public var delegate: PlayerControlDelegate? = nil
```

Sets the delegate. See "Responding to Events" below. This is technically 
optional, but not implementing it doesn't make a lot of sense. :)

```swift
@IBInspectable public var jumpForwardTimeInternal: TimeInterval = 15
```

How far ahead will pushing the Jump Ahead button advance the time. If pushing 
the button would advance the time beyond the end of the media, the time is set 
at the end of the media.

```swift
@IBInspectable public var jumpBackwardTimeInterval: TimeInterval = 15
```

How far back will pushing the Jump Backward button reduce the time. If pushing
the button would reduce the time beyond the beginning of the media, the time is
set at 0.

```swift
public var transferred: CGFloat = 0
```

If you are using the downloading display to show how much of a streaming file 
has transferred, updating this will cause that to be displayed in the slider. 
This is a float between 0.0 and 1.0 representing the percentage of the file
transferred.

```swift
@IBInspectable public var hideOnMouseOut: Bool = true
```

If you want the display to hide when the mouse exits the view. The mouse re-
entering the bounds of the view will cause it to become visible again.

```swift
public var hideAfter: TimeInterval = 5
```

The view is initially visible. If `hideOnMouseOut` is true, this is how long the
view will remain visible before being hidden.

```swift
public var hiddenAlphaValue: CGFloat = 0
```

Sets the alpha value when the control is hidden.

```swift
public var visibleAlphaValue: CGFloat = 1
```

Sets the alpha value when the control is visible.

```swift
public var status: Status = .paused
```

Sets the current status of the PlayerControl. Options are `.playing` or 
`.paused`. This should be updated from your controller if something changes. If
you are using `VLCKit`, it should be updated from the `mediaPlayerStateChanged`
delegate method. This will also be updated by the control reflecting changes by
the user. This will trigger a delegate method call.

```swift
public var theme: PlayerControlTheme = Dark()
```

The theme to use. `Dark` is the default, but `Light` is also available. See the
section on Themes below.

```swift
@IBInspectable public var iconSize = NSSize(width: 100, height: 100)
```

The size of icons to use. This should be set to the largest possible size that
will be used on your play/pause button. It will be automatically scaled down for
your smaller buttons.

```swift
@IBInspectable public var showRewindButton: Bool = true
```

Whether the Rewind button is visible.

```swift
@IBInspectable public var showFastForwardButton: Bool = true
```

Whether the Fast Forward button is visible.

```swift
@IBInspectable public var showJumpBackButton: Bool = true
```

Whether the Jump Back button is visible.

```swift
@IBInspectable public var showForwardButton: Bool = true
```

Whether the Jump Forward button is visible.

```swift
@IBInspectable public var showLabels: Bool = true
```

Whether the time labels are visible.

```swift
@IBInspectable public var rewindbuttonImage: NSImage?
```

The image used on the Rewind button.

```swift
@IBInspectable public var fastForwardButtonImage: NSImage?
```

The image used on the Fast Forward button.

```swift
@IBInspectable public var jumpBackButtonImage: NSImage?
```

The image used on the Jump Back button.

```swift
@IBInspectable public var jumpForwardButtonImage: NSImage?
```

The image used on the Jump Forward button.

```swift
@IBInspectable public var playButtonImage: NSImage?
```

The image used on the Play button.

```swift
@IBInspectable public var pauseButtonImage: NSImage?
```

The image used on the Pause button. From a technical standpoint, Play and Pause
are the same button, and the image is swapped depending on the state.

### Themes

`PlayerControl` supports themes that can control some parts of the appearance 
of the control. Two themes are included, `Light` and `Dark` and `Dark` is the 
default. You can create your own themes by creating a class or struct that 
implements the `PlayerControlTheme` protocol, then setting the `theme:` property
on the `PlayerControl` class to an instance of your theme.

You can customize the following variables:

```swift
public var blendingMode: NSVisualEffectView.BlendingMode
```
Sets the underlying view's blending mode.

```swift
public var material: NSVisualEffectView.Material
```
Sets the underlying view's material.

```swift
public var buttonColor: NSColor
```
The background color used on buttons.

```swift
public var buttonAlpha: CGFloat
```
The alpha transparency used on buttons.

```swift
public var labelTextColor: NSColor
```
The text color on time labels.

```swift
public var sliderKnobColor: NSColor
```
The color of the slider knob (line).

```swift
public var sliderBarColor: NSColor
```
The color of the slider bar.

```swift
public var sliderBarDownloadColor: NSColor
```
The color of the part of the bar representing the download percentage.

```swift
public var sliderBarAlpha: CGFloat
```
The alpha transparency of the bar.

### Responding to Events

To respond to PlayerControl events, you can implement the 
`PlayerControlDelegate` in your controller. This will provide you with the 
following callback events:

```swift
func statusChanged(_ playerControl: PlayerControl, status: PlayerControl.Status)
```

Called when the status of the player changes. You are passed back an instance of
the calling `PlayerControl` and the status, which is one of `.playing` or 
`.paused`. This is called **after** the user pressed play or pause.

```swift
func timeChanged(_ playerControl: PlayerControl, time: TimeInterval)
```

Called when the controls change the current time of playback. This can be called
by a number of actions, including sliding the slider, or using the playback 
buttons like jump ahead/back, or fast forward or rewind. The `TimeInterval` is
the **new** time interval.

Don't forget to set your class as the delegate.

## Author

Rebecca Peck

## License

MIT
