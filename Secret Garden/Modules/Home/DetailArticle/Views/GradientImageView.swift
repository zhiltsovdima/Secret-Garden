//
//  GradientImageView.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 25.05.2023.
//

import UIKit

final class GradientImageView: UIImageView {
    
    private let topGradientLayer = CAGradientLayer()
    private let bottomGradientLayer = CAGradientLayer()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        topGradientLayer.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height / 2)
        bottomGradientLayer.frame = CGRect(x: 0, y: bounds.height / 2, width: bounds.width, height: bounds.height / 2)
    }
    
    func setupGradient() {
        let darkColor = UIColor.black.withAlphaComponent(0.5).cgColor
        let lightColor = UIColor.clear.cgColor
        topGradientLayer.colors = [darkColor, lightColor]
        topGradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        topGradientLayer.endPoint = CGPoint(x: 0.5, y: 0.5)
        
        bottomGradientLayer.colors = [lightColor, darkColor]
        bottomGradientLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
        bottomGradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        layer.addSublayer(topGradientLayer)
        layer.addSublayer(bottomGradientLayer)
    }
}
