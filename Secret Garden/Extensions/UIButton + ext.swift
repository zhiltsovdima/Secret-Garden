//
//  UIButton + ext.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 15.02.2023.
//

import UIKit

extension UIButton {
    
    func makeSystemAnimation() {
        self.addTarget(self, action: #selector(handleIn), for: [
            .touchDown,
            .touchDragInside
        ])
        self.addTarget(self, action: #selector(handleOut), for: [
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
