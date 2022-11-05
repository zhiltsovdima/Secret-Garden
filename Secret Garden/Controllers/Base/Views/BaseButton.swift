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
    
    func configureAppearance() {
        backgroundColor = Resources.Colors.accent
        layer.cornerRadius = 20
        setTitleColor(Resources.Colors.backgroundColor, for: .normal)
        makeSystemAnimation(for: self)
    }
    
}