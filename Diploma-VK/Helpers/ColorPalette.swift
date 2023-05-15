//
//  ColorPalette.swift
//  Diploma-VK
//
//  Created by Pavel Yurkov on 28.03.2022.
//

import UIKit

struct ColorPalette {
    /// белый
    static let primaryColor = UIColor(hex: "#ffffff")
    /// бежевый
    static let secondaryColor = UIColor(hex: "#F5F3EE")
    /// темно-синий
    static let thirdColor = UIColor(hex: "#263238")
    /// серый
    static let fourthColor = UIColor(hex: "#7E8183")
    /// оранжевый
    static let fifthColor = UIColor(hex: "#FF9E45")
    /// lightGray
    static let sixthColor = UIColor.lightGray
    /// black
    static let seventhColor = UIColor.black
    
}

extension UIColor {
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
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
}

extension CGColor {
    class func colorWithHex(hex: String) -> CGColor {
        return UIColor(hex: hex).cgColor
    }
}
