//
//  Extensions.swift
//  RemindMe
//
//  Created by Ishwar Silwal on 9/17/19.
//  Copyright © 2019 Ishwar Silwal. All rights reserved.
//

import UIKit
import Toast_Swift

extension Double {
    func formatToDigit(_ position: Int) -> String {
        return String(format: "%.\(position)f", self)
    }
}

extension UITableView {
    func registerIdentifier(_ identifier:String) {
        self.register(UINib.init(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
}

extension UIViewController {
    func loadStory(_ storyBoardId:String, fromBoard name:String = "Main") -> UIViewController {
        let storyBoard = UIStoryboard.init(name: name, bundle: .main)
        let story = storyBoard.instantiateViewController(withIdentifier: storyBoardId);
        return story;
    }
}

extension UIView {
    
    func disableDarkMode() {
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
    }
    
    func addTapGesture() -> UITapGestureRecognizer {
        let tapGesture = UITapGestureRecognizer.init()
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        self.addGestureRecognizer(tapGesture)
        return tapGesture
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func showBorder(width:CGFloat, color:UIColor, cornerRadius:CGFloat) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
        layer.cornerRadius = cornerRadius
    }
    
    func removeLayer(withName name:String) {
        var layers = [CALayer]()
        if let sublayers = self.layer.sublayers {
            for layer in sublayers {
                if layer.name == name {
                    layers.append(layer)
                }
            }
        }
        
        for layer in layers {
            layer.removeFromSuperlayer()
        }
    }
    
    func gradient(colors: [CGColor], name:String) {
        removeLayer(withName: name)
        let gradientLayer = CAGradientLayer()
        gradientLayer.name = name
        gradientLayer.frame = bounds
        gradientLayer.colors = colors
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func showToastMessage(_ message:String) {
        self.hideAllToasts()
        if message.count == 0 {
            return
        }
        self.makeToast(message, duration: 3.0, position: .bottom)
    }
    
    func bounce() {
        self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.3, options: .beginFromCurrentState, animations: {
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
    }
    
    func addShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
    }
    
    func loadXib(_ name:String) -> UIView {
        return UINib.init(nibName: name, bundle: nil).instantiate(withOwner: nil, options: nil).first as! UIView
    }
}

extension UIImageView {
    func loadImage(imageName:String, tintColor:UIColor? = nil) {
        if let color = tintColor {
            image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
            self.tintColor = color
        }
        else {
            image = UIImage(named: imageName)
        }
    }
}

extension UIButton {
    func configureWith(title:String, titleColor:UIColor, backgroundColor:UIColor, cornerRadius:CGFloat) {
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        layer.cornerRadius = cornerRadius
    }
    
    func configureWith(imageName:String, tintColor:UIColor?, backgroundColor:UIColor, cornerRadius:CGFloat) {
        
        if let color =  tintColor {
            setImage(UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate), for: .normal)
            self.tintColor = color
        }
        else {
            setImage(UIImage(named: imageName), for: .normal)
        }
        
        self.backgroundColor = backgroundColor
        layer.cornerRadius = cornerRadius
    }
}

extension UILabel {
    
    func configureWith(fontName:String, fontSize:CGFloat, fontColor:UIColor) {
        let font = UIFont(name: fontName, size: fontSize)
        self.font = font
        textColor = fontColor
    }
}

extension Date {
    
   func toString() -> String {
       let dateFormatter = DateFormatter()
       dateFormatter.dateStyle = .medium
       dateFormatter.timeStyle = .short
       return dateFormatter.string(from:self)
   }
}

extension String {
    
    func toDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        guard let date = dateFormatter.date(from:self) else {
            return Date()
        }
        return  date
    }
    
    func lowerCasedFirstLetter() -> String {
        return prefix(1).lowercased() + self.dropFirst()
    }
    
    func capitalizedFirstLetter() -> String {
        return prefix(1).uppercased() + self.dropFirst()
    }
}

extension UITextField {
    func configureWith(fontName:String, fontSize:CGFloat, fontColor:UIColor) {
        let font = UIFont(name: fontName, size: fontSize)
        self.font = font
        textColor = fontColor
    }
}
