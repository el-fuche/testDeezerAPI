# PlaceholderImage
use to display temporary images in development.

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

## Features
- use to display temporary images in development.

## How to use
if need memory cache, use singleton object to create image.
if don't need memory cache, use class methods.

```swift
/// MARK: if need memory cache, use singleton object to create image.
// create a placeholder image of rectangle
let rectangleImage = PlaceholderImage.shared.rect(width: 100, height: 100, color: UIColor.black)
let rectangleImageView = UIImageView(image: rectangleImage)
rectangleImageView.frame = CGRect(x: 50, y: 50, width: 100, height: 100)
view.addSubview(rectangleImageView)

// create a placeholder image of circle
let circleImage = PlaceholderImage.shared.circle(width: 50, height: 50, color: UIColor.red, textColor: UIColor.black)
let circleImageView = UIImageView(image: circleImage)
circleImageView.frame = CGRect(x: 50, y: 150, width: 50, height: 50)
view.addSubview(circleImageView)

/// MARK:  if don't need memory cache, use class methods.
let rectangleImage2 = PlaceholderImage.rect(width: 100, height: 100, color: UIColor.black)
let rectangleImageView2 = UIImageView(image: rectangleImage2)
rectangleImageView2.frame = CGRect(x: 100, y: 250, width: 100, height: 100)
view.addSubview(rectangleImageView2)

// create a placeholder image of circle
let circleImage2 = PlaceholderImage.circle(width: 50, height: 50, color: UIColor.red, textColor: UIColor.black)
let circleImageView2 = UIImageView(image: circleImage2)
circleImageView2.frame = CGRect(x: 100, y: 350, width: 50, height: 50)
view.addSubview(circleImageView2)
```

## Runtime Requirements

- iOS 8.0 or later
- Xcode 9.2 - Swift4

## Installation and Setup
### Installing with Carthage

Just add to your Cartfile:

```ogdl
github "fuji2013/PlaceholderImage"
```

### Installing with CocoaPods

[CocoaPods](http://cocoapods.org) is a centralised dependency manager that automates the process of adding libraries to your Cocoa application. You can install it with the following command:

```bash
$ gem update
$ gem install cocoapods
$ pods --version
```

To integrate PlaceholderImage into your Xcode project using CocoaPods, specify it in your `Podfile` and run `pod install`.

```bash
platform :ios, '8.0'
use_frameworks!
pod "PlaceholderImage", '~>1.0.0'
```

### Manual Installation

To install PlaceholderImage without a dependency manager, please add `PlaceholderImage.swift` to your Xcode Project.

## Contribution

Please file issues or submit pull requests for anything you’d like to see! We're waiting! :)

## License
PlaceholderImage.swift is released under the MIT license. Go read the LICENSE file for more information.
