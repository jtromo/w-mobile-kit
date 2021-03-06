# WMobileKit

[![Version](https://img.shields.io/cocoapods/v/WMobileKit.svg?style=flat)](http://cocoapods.org/pods/WMobileKit)
[![License](https://img.shields.io/cocoapods/l/WMobileKit.svg?style=flat)](http://cocoapods.org/pods/WMobileKit)
[![Platform](https://img.shields.io/cocoapods/p/WMobileKit.svg?style=flat)](http://cocoapods.org/pods/WMobileKit)

WMobileKit is a Swift library containing various custom UI components to provide functionality outside of the default libraries.

## Features

- Customizable
- Example App
- Components
 - [x] WActionSheet
 - [x] WAutoCompleteTextView
 - [x] WBadge
 - [x] WBanner
 - [x] WLabel
 - [x] WLoadingModal
 - [x] WRadioButton
 - [x] WSideMenuVC
 - [x] WSizeVC
 - [x] WSpinner
 - [x] WSwitch
 - [x] WTextField
 - [x] WTextView
 - [x] WTheme
 - [x] WToast
 - [x] WUserLogoView
 - [x] WUtils

## Usage

To use the library in your app, add the following import to your file:
```swift
import WMobileKit
```

To run the example project, run `./setup.sh` in the root directory.
Alternatively, you can run `pod install` from the Example directory.

## Requirements

 - `use_frameworks!` must be at the top of your Podfile (since this is a Swift pod)
 - iOS 8.0+
 - Xcode 6.0

## Installation

Add the following to your Podfile:
```ruby
pod "WMobileKit"
```

### Known Issues

#### use_frameworks missing

Error:
```ruby
[!] Pods written in Swift can only be integrated as frameworks; this feature is still in beta. Add `use_frameworks!` to your Podfile or target to opt into using it. The Swift Pod being used is: WMobileKit
    Warning: Command failed:  Use --force to continue.
```

Solution:
- Add `use_frameworks` to the top of your Podfile

## License

WMobileKit is available under the Apache license. See the LICENSE file for more info.

## Authors
- James Romo
- Jordan Ross
- Jeff Scaturro
- Todd Tarbox
- Brian Blanchard
- Bryan Rezende
