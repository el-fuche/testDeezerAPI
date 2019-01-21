//
//  PlaceholderImage.swift
//  PlaceholderImage
//
//  Created by hf on 2017/12/16.
//  Copyright © 2017年 swift-studying.com. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit

public class PlaceholderImage {
    /**
     Singleton Object.
     If require same image, This use memory cache.
    */
    public static let shared = PlaceholderImage(useMemoryCache: true)
    
    /**
     Initializer
     - parameter userMemoryCache: if use memory cache, true. Default is false.
     */
    public init(useMemoryCache: Bool = false) {
        if useMemoryCache {
            self.cache = NSCache<NSString, UIImage>()
        }
    }
    
    /**
     Deinitializer
     */
    deinit {
        self.cache?.removeAllObjects()
    }
    
    /**
     Circle image
     - parameter width: circle width
     - parameter height: circle height
     - parameter hex: circle color. specify hex string. ex: d3c815
     - parameter textHexColor: text color in circle. specify hex string. ex: d3c815
     - returns UIImage
     */
    public func circle(width: CGFloat, height: CGFloat, hex: String, textHexColor: String = "ffffff") -> UIImage {
        return circle(width: width, height: height, color: UIColor(hex: hex), textColor: UIColor(hex: textHexColor))
    }
    
    /**
     Circle image
     - parameter width: circle width
     - parameter height: circle height
     - parameter color: circle color
     - parameter textColor: text color in circle
     - returns UIImage
     */
    public func circle(width: CGFloat, height: CGFloat, color: UIColor, textColor: UIColor = UIColor.white) -> UIImage {
        let key = "circle\(width)\(height)\(color.hexString())\(textColor.hexString())" as NSString
        
        if let contents = cache?.object(forKey: key) {
            return contents
        }
        
        let image = PlaceholderImage.circle(width: width, height: height, color: color, textColor: textColor)
        
        cache?.setObject(image, forKey: key)
        
        return image
    }
    
    /**
     Circle image
     - parameter width: circle width
     - parameter height: circle height
     - parameter color: circle color
     - parameter textHexColor: text color in rectangle. specify hex string. ex: d3c815
     - returns UIImage
     */
    public class func circle(width: CGFloat, height: CGFloat, hex: String, textHexColor: String = "ffffff") -> UIImage {
        return circle(width: width, height: height, color: UIColor(hex: hex), textColor: UIColor(hex: textHexColor))
    }
    
    /**
     Circle image
     - parameter width: circle width
     - parameter height: circle height
     - parameter color: circle color
     - parameter textColor: text color in circle
     - returns UIImage
     */
    public class func circle(width: CGFloat, height: CGFloat, color: UIColor, textColor: UIColor = UIColor.white) -> UIImage {
        let text = "\(width)x\(height)"
        
        let layer = oval(width: width, height: height, color: color)
        let textLayer = string(text: text, width: width, height: height, textColor: textColor)
        layer.addSublayer(textLayer)
        let image = layer.toUIImage(width: width, height: height)
        
        return image
    }
    
    /**
     Rectangle image
     - parameter width: rectangle width
     - parameter height: rectangle height
     - parameter color: rectangle color
     - parameter textHexColor: text color in rectangle. specify hex string. ex: d3c815
     - returns UIImage
     */
    public func rect(width: CGFloat, height: CGFloat, hex: String, textHexColor: String = "ffffff") -> UIImage {
        return rect(width: width, height: height, color: UIColor(hex: hex), textColor: UIColor(hex: textHexColor))
    }
    
    /**
     Rectangle image
     - parameter width: rectangle width
     - parameter height: rectangle height
     - parameter color: rectangle color
     - parameter textColor: text color in rectangle
     - returns UIImage
     */
    public func rect(width: CGFloat, height: CGFloat, color: UIColor, textColor: UIColor = UIColor.white) -> UIImage {
        let key = "rectangle\(width)\(height)\(color.hexString())\(textColor.hexString())" as NSString
        
        if let contents = cache?.object(forKey: key) {
            return contents
        }
        
        let image = PlaceholderImage.rect(width: width, height: height, color: color, textColor: textColor)
        
        cache?.setObject(image, forKey: key)
        
        return image
    }
    
    /**
     Rectangle image
     - parameter width: rectangle width
     - parameter height: rectangle height
     - parameter color: rectangle color
     - parameter textHexColor: text color in rectangle. specify hex string. ex: d3c815
     - returns UIImage
     */
    public class func rect(width: CGFloat, height: CGFloat, hex: String, textHexColor: String = "ffffff") -> UIImage {
        return rect(width: width, height: height, color: UIColor(hex: hex), textColor: UIColor(hex: textHexColor))
    }
    
    /**
     Rectangle image
     - parameter width: rectangle width
     - parameter height: rectangle height
     - parameter color: rectangle color
     - parameter textColor: text color in rectangle
     - returns UIImage
     */
    public class func rect(width: CGFloat, height: CGFloat, color: UIColor, textColor: UIColor = UIColor.white) -> UIImage {
        let text = "\(width)x\(height)"
        let rect = CGRect(origin: CGPoint.zero, size: CGSize(width: width, height: height))
        
        let rectLayer = PlaceholderImage.rectangle(width: rect.size.width, height: rect.size.height, color: color)
        let textLayer = PlaceholderImage.string(text: text, width: width, height: height, textColor: textColor)
        rectLayer.addSublayer(textLayer)
        
        return rectLayer.toUIImage(width: width, height: height)
    }
    
    /// MARK: Private
    private var cache: NSCache<NSString, UIImage>?
    
    private class func rectangle(width: CGFloat, height: CGFloat, color: UIColor) -> CAShapeLayer {
        let layer = CAShapeLayer()
        layer.path = UIBezierPath(rect: CGRect(origin: CGPoint.zero, size: CGSize(width: width, height: height)) ).cgPath
        layer.fillColor = color.cgColor
        
        return layer
    }
    
    private class func oval(width: CGFloat, height: CGFloat, color: UIColor) -> CAShapeLayer {
        let layer = CAShapeLayer()
        layer.path = UIBezierPath(ovalIn: CGRect(origin: CGPoint.zero, size: CGSize(width: width, height: height))).cgPath
        layer.fillColor = color.cgColor
        
        return layer
    }
    
    private class func string(text: String, width: CGFloat, height: CGFloat, textColor: UIColor) -> CATextLayer {
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        
        let textLayer = CATextLayer()
        var fontSize: CGFloat = 200
        var textSize: CGSize = CGSize.zero
        
        while true {
            let attributes = [
                NSAttributedStringKey.font: UIFont.systemFont(ofSize: fontSize)
            ]
            textSize = (text as NSString).size(withAttributes: attributes)
            if textSize.width <= rect.size.width && textSize.height <= rect.size.height {
                break
            }
            fontSize -= 1
        }
        
        let centerY = rect.midY - (textSize.height * 0.5)
        textLayer.frame = CGRect(x: rect.origin.x, y: centerY, width: rect.size.width, height: rect.size.height)
        textLayer.isWrapped = false
        textLayer.alignmentMode = kCAAlignmentCenter
        textLayer.fontSize = fontSize
        textLayer.string = text
        textLayer.foregroundColor = textColor.cgColor
        
        return textLayer
    }
}

fileprivate extension CALayer {
    func toUIImage(width: CGFloat, height: CGFloat) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        guard let context = UIGraphicsGetCurrentContext() else{
            UIGraphicsEndImageContext()
            return UIImage()
        }
        
        self.render(in: context)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else{
            UIGraphicsEndImageContext()
            return UIImage()
        }
        UIGraphicsEndImageContext()
        
        return image
    }
}

fileprivate extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
    
    func hexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        
        return NSString(format:"#%06x", rgb) as String
    }
}
