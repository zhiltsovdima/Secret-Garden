//
//  ShopFeatureView.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 05.02.2023.
//

import UIKit

final class ShopFeatureView: UIView {
    
    let featureImage = UIImageView()
    let nameLabel = UILabel()
    let valueLabel = UILabel()
    
    func setup(image: UIImage?, name: String, value: String) {
        featureImage.image = image
        nameLabel.text = name
        valueLabel.text = value
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        addSubview(featureImage)
        addSubview(nameLabel)
        addSubview(valueLabel)
        
        featureImage.setContentHuggingPriority(.defaultHigh, for: .horizontal)
                
        nameLabel.font = Resources.Fonts.subHeaders
        nameLabel.textColor = Resources.Colors.subHeader
        nameLabel.numberOfLines = 0
        nameLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        valueLabel.font = Resources.Fonts.generalBold
        valueLabel.numberOfLines = 0

    }
    
    func setupConstraints() {
        featureImage.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            featureImage.topAnchor.constraint(equalTo: topAnchor),
            featureImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            nameLabel.centerYAnchor.constraint(equalTo: featureImage.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: featureImage.trailingAnchor, constant: 5),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            valueLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            valueLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            valueLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
