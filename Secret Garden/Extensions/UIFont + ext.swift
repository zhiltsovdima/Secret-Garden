//
//  UIFont + ext.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 10.05.2023.
//

import UIKit.UIFont

extension UIFont {
    
    static func regular(with size: CGFloat) -> UIFont? {
        return UIFont(name: "Montserrat-Regular", size: size)
    }
    
    static func bold(with size: CGFloat) -> UIFont? {
        return UIFont(name: "Montserrat-Bold", size: size)
    }
    
    static func light(with size: CGFloat) -> UIFont? {
        return UIFont(name: "Montserrat-Light", size: size)
    }
    
    static func medium(with size: CGFloat) -> UIFont? {
        return UIFont(name: "Montserrat-Medium", size: size)
    }
    
    static func semiBold(with size: CGFloat) -> UIFont? {
        return UIFont(name: "Montserrat-SemiBold", size: size)
    }
    
}
