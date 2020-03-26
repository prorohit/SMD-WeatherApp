//
//  UIColor+Extension.swift
//  WeatherApp
//
//  Created by Rohit Singh on 26/03/2020.
//  Copyright © 2020 SMD. All rights reserved.
//

import UIKit

extension UIColor {
    class var appGreenColor: UIColor {
        return UIColor(hexString: "#8DC73F")
    }
    
    class var appLightGreen: UIColor {
        return UIColor(redValue: 141, greenValue: 199, blueValue: 63, a: 0.4)
    }
    
    class var appDarkBlueColor: UIColor {
           return UIColor(hexString: "#264C82")
       }
    
    class var appBlueColor: UIColor {
        return UIColor(redValue: 38, greenValue: 76, blueValue: 130, a: 0.7)
    }
    
    
}

extension UIColor {
    
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
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
    
    convenience init(redValue: Int, greenValue: Int, blueValue: Int, a: CGFloat = 1.0) {
        self.init(
            red: CGFloat(redValue) / 255.0,
            green: CGFloat(greenValue) / 255.0,
            blue: CGFloat(blueValue) / 255.0,
            alpha: a
        )
    }
    
}
