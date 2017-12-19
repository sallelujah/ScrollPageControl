//
//  UIColor_Extension.swift
//  ScrollPageControl
//
//  Created by Lawrence on 2017/12/19.
//  Copyright © 2017年 lawrece. All rights reserved.
//


import UIKit

extension UIColor {
    
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    /// VI设计基本色调
    class func unityRedColor() -> UIColor{
        return UIColor(hexString: "ff4d4d")
    }
    class func unityGrayColor() -> UIColor{
        return UIColor(hexString: "E7E9EE")
    }
    class func unityBlackColor() -> UIColor{
        return UIColor(hexString: "333333")
    }
    class func unityTextColor() -> UIColor{
        return UIColor(hexString: "666666")
    }
    class func unitySubTitleColor() -> UIColor{
        return UIColor(hexString: "999999")
    }
    class func unityOrangeColor() -> UIColor{
        return UIColor(hexString: "FE7453")
    }
    class func unityBackGroundColor() -> UIColor{
        return UIColor(hexString: "F1F1F1")
    }
    class func unitySeperatorLineColor() -> UIColor{
        return UIColor(hexString: "e3e3e5")
    }
    
    class func unityDeepBlue() -> UIColor{
        return UIColor(hexString: "44495D")
    }
    class func unityRGBDeepBlue() -> UIColor{
        return UIColor(red: 254/255.0, green: 116/255.0, blue: 83/255.0, alpha: 1.0)
    }
    class func unityRGBWhite() -> UIColor{
        return UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0)
    }
    
}

