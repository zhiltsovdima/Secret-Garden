//
//  PlaceholderView.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 04.02.2023.
//

import UIKit

class PlaceholderView: UIView {
    
    private let placeholderImage = UIImageView()
    private let placeholderLabel = UILabel()
    let placeholderButton = BaseButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(placeholderImage)
        addSubview(placeholderLabel)
        addSubview(placeholderButton)
        
        placeholderImage.image = Resources.Images.Common.shopPlant
        placeholderImage.contentMode = .scaleAspectFit
        
        placeholderLabel.text = Resources.Strings.Shop.emptyLabel
        placeholderLabel.font = Font.generalBold
        placeholderLabel.textAlignment = .center
        
        placeholderButton.setTitle(Resources.Strings.Shop.emptyButton, for: .normal)
    }
    
    private func setupConstraints() {
        
        placeholderImage.translatesAutoresizingMaskIntoConstraints = false
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        placeholderButton.translatesAutoresizingMaskIntoConstraints = false
                
        NSLayoutConstraint.activate([
            placeholderImage.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            placeholderImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            placeholderImage.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            placeholderImage.bottomAnchor.constraint(equalTo: placeholderLabel.topAnchor),

            placeholderLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            placeholderLabel.centerYAnchor.constraint(equalTo: centerYAnchor),

            placeholderButton.topAnchor.constraint(equalTo: placeholderLabel.bottomAnchor, constant: 20),
            placeholderButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            placeholderButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            placeholderButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
}
