 //
//  UIView + ext.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 03.11.2022.
//

import UIKit

extension UIView {
    
    func addUpperBorder(with color: UIColor, height: CGFloat) {
        let separator = UIView()
        separator.backgroundColor = color
        separator.frame = CGRect(x: 0,
                                 y: 0,
                                 width: frame.width,
                                 height: height)
        addSubview(separator)
    }
    
    func makeSystemAnimation(for button: UIButton) {
        button.addTarget(self, action: #selector(handleIn), for: [
            .touchDown,
            .touchDragInside
        ])
        button.addTarget(self, action: #selector(handleOut), for: [
            .touchUpOutside,
            .touchUpInside,
            .touchDragExit,
            .touchDragInside,
            .touchCancel
        ])
    }
    
    @objc func handleIn() {
        UIView.animate(withDuration: 0.15) {
            self.alpha = 0.55
        }
    }
    
    @objc func handleOut() {
        UIView.animate(withDuration: 0.15) {
            self.alpha = 1
        }
    }
}
