//
//  ExtensionManager.swift
//  MovieDemop
//
//  Created by Jigar Patel on 05/01/19.
//  Copyright © 2019 BrainyBeam. All rights reserved.
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
}
    extension UIImageView
    {
        func roundCornersForAspectFit(radius: CGFloat)
        {
            if let image = self.image {
                
                //calculate drawingRect
                let boundsScale = self.bounds.size.width / self.bounds.size.height
                let imageScale = image.size.width / image.size.height
                
                var drawingRect: CGRect = self.bounds
                
                if boundsScale > imageScale {
                    drawingRect.size.width =  drawingRect.size.height * imageScale
                    drawingRect.origin.x = (self.bounds.size.width - drawingRect.size.width) / 2
                } else {
                    drawingRect.size.height = drawingRect.size.width / imageScale
                    drawingRect.origin.y = (self.bounds.size.height - drawingRect.size.height) / 2
                }
                let path = UIBezierPath(roundedRect: drawingRect, cornerRadius: radius)
                let mask = CAShapeLayer()
                mask.path = path.cgPath
                self.layer.mask = mask
            }
        }
    }
    extension UIView {
        func fadeTo(_ alpha: CGFloat, duration: TimeInterval? = 0.3) {
            DispatchQueue.main.async {
                UIView.animate(withDuration: duration != nil ? duration! : 0.3) {
                    self.alpha = alpha
                }
            }
        }
        
        func fadeIn(_ duration: TimeInterval? = 0.3) {
            fadeTo(1.0, duration: duration)
        }
        func fadeOut(_ duration: TimeInterval? = 0.3) {
            fadeTo(0.0, duration: duration)
        }
        
        func roundCorners(corners: UIRectCorner, radius: CGFloat) {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    }
    @IBDesignable extension UIView {
        @IBInspectable var borderColor:UIColor? {
            set {
                layer.borderColor = newValue!.cgColor
            }
            get {
                if let color = layer.borderColor {
                    return UIColor.init(cgColor: color)
                }
                else {
                    return nil
                }
            }
        }
        @IBInspectable var borderWidth:CGFloat {
            set {
                layer.borderWidth = newValue
            }
            get {
                return layer.borderWidth
            }
        }
        @IBInspectable var cornerRadius:CGFloat {
            set {
                layer.cornerRadius = newValue
                clipsToBounds = newValue > 0
            }
            get {
                return layer.cornerRadius
            }
        }
        @IBInspectable public var cornerRadiusRatio: CGFloat {
            get {
                return layer.cornerRadius / frame.width
            }
            
            set {
                // Make sure that it's between 0.0 and 1.0. If not, restrict it
                // to that range.
                let normalizedRatio = max(0.0, min(1.0, newValue))
                layer.cornerRadius = frame.width * normalizedRatio
            }
        }
    }


