 //
//  UIView + ext.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 03.11.2022.
//

import UIKit

extension UIView {
    
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
