//
//  BaseButton.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 03.11.2022.
//

import UIKit

class BaseButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = bounds.height * 0.5
    }
    
    func configureAppearance() {
        backgroundColor = Resources.Colors.accent
        setTitleColor(.white, for: .normal)
        titleLabel?.font = Font.buttonFont
        makeSystemAnimation()
    }
    
}
