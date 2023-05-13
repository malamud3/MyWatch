//
//  Extensions.swift
//  GameStore_UIkit
//
//  Created by Amir Malamud on 05/12/2022.
//

import UIKit
import MaterialComponents

extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
        }
    func fixFormatDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: self)!
        
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: date)
    }
}

extension UIImage {
    func scaled(to size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContext(size)
        draw(in: CGRect(origin: .zero, size: size))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImage
    }
    
}
    extension UIButton {
        static func createMetallicButton(withImageNamed imageName: String) -> UIButton {
            let button = UIButton()
            button.setImage(UIImage(named: imageName), for: .normal)
            button.layer.cornerRadius = button.bounds.height / 2
            button.layer.masksToBounds = false            
            button.layer.shadowColor = UIColor.darkGray.cgColor
            button.layer.shadowOpacity = 1
            button.layer.shadowOffset = CGSize(width: 0, height: 2)
            button.layer.shadowRadius = 2
            return button
        }
    }

extension MDCButton {
    func applyCustomContainedButtonStyle() {
        let scheme = MDCContainerScheme()
        let buttonColor = UIColor(red: 0.07, green: 0.05, blue: 0.65, alpha: 1.0)
        let buttonHighlightedColor = UIColor(red: 0.08, green: 0.05, blue: 0.55, alpha: 0.8)
        
        setBackgroundColor(buttonColor, for: .normal)
        setBackgroundColor(buttonHighlightedColor, for: .highlighted)
        setTitleColor(UIColor.white, for: .normal)
        layer.cornerRadius = 10.0
        layer.shadowColor = UIColor.white.cgColor
        layer.shadowOpacity = 0.6
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowRadius = 10
        setElevation(ShadowElevation(rawValue: 10), for: .normal)
        applyContainedTheme(withScheme: scheme)
    }
}
extension UIColor {
    convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}




