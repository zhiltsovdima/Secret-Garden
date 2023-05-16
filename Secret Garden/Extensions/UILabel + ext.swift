//
//  UILabel + ext.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 16.05.2023.
//

import UIKit

extension UILabel {
    func setLineSpacing(_ spacing: CGFloat) {
        guard let text else { return }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        
        let attibute = [NSAttributedString.Key.paragraphStyle : paragraphStyle]
        let attributedString = NSMutableAttributedString(string: text, attributes: attibute)
        attributedText = attributedString
    }
}
