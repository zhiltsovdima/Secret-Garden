//
//  PriceView.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 09.02.2023.
//

import UIKit

final class PriceView: UIView {
    
    private let priceStackView = UIStackView()
    private let priceLabel = UILabel()
    private let priceValueLabel = UILabel()
    
    let addToCartButton = BaseButton()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addToCartButton.widthAnchor.constraint(equalToConstant: frame.width * 0.5).isActive = true
    }
    
    func setup(price: String) {
        priceValueLabel.text = price
        setupViews()
        setupConstraints()
    }
    
    func setCartButtonAppearance(isAddedToCart: Bool) {
        if isAddedToCart {
            addToCartButton.setTitle(Resources.Strings.Shop.added, for: .normal)
            addToCartButton.setTitleColor(Resources.Colors.whiteOnBlack, for: .normal)
            addToCartButton.backgroundColor = Resources.Colors.blackOnWhite
        } else {
            addToCartButton.setTitle(Resources.Strings.Shop.addToCart, for: .normal)
            addToCartButton.backgroundColor = Resources.Colors.accent
        }
    }
    
    private func setupViews() {
        addSubview(priceStackView)
        addSubview(addToCartButton)
        
        priceStackView.addArrangedSubview(priceLabel)
        priceStackView.addArrangedSubview(priceValueLabel)
        priceStackView.axis = .vertical
        priceStackView.alignment = .leading
        
        priceLabel.text = Resources.Strings.Shop.price
        priceLabel.font = Font.generalBold
        priceLabel.textColor = Resources.Colors.lightText
        priceLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)

        priceValueLabel.font = Font.header
    }
    
    private func setupConstraints() {
        
        priceStackView.translatesAutoresizingMaskIntoConstraints = false
        addToCartButton.translatesAutoresizingMaskIntoConstraints = false
                
        NSLayoutConstraint.activate([
            priceStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            priceStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            priceStackView.trailingAnchor.constraint(equalTo: addToCartButton.leadingAnchor),
            priceStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            addToCartButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            addToCartButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            addToCartButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
    }
}
