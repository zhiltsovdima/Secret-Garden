//
//  ItemCell.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 12.11.2022.
//

import UIKit

class ItemCell: UICollectionViewCell {
    
    private var imageView = UIImageView()
    private var name: String?
    private let favoriteButton = UIButton()
    private let addToCartButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setItem(_ item: ShopItem) {
        name = item.name
        imageView.image = item.image
    }
    
    private func configure() {
        favoriteButton.frame = CGRect(x: 0, y: 0, width: frame.width * 0.25, height: frame.width * 0.25)
        addToCartButton.frame = CGRect(x: 0, y: 0, width: 0, height: frame.width * 0.25)
        
        addSubview(imageView)

        contentView.addSubview(favoriteButton)
        favoriteButton.setImage(Resources.Images.Common.addToFavorite, for: .normal)
        favoriteButton.backgroundColor = Resources.Colors.backgroundColor
        favoriteButton.tintColor = .black
        favoriteButton.layer.cornerRadius = favoriteButton.frame.height * 0.5
        favoriteButton.layer.borderWidth = 0.1
        
        contentView.addSubview(addToCartButton)
        addToCartButton.setTitle(Resources.Strings.Shop.addToCart, for: .normal)
        addToCartButton.setTitleColor(.black, for: .normal)
        addToCartButton.titleLabel?.font = addToCartButton.titleLabel?.font.withSize(13)
        addToCartButton.backgroundColor = Resources.Colors.backgroundColor
        addToCartButton.layer.cornerRadius = addToCartButton.frame.height * 0.5
        addToCartButton.layer.borderWidth = 0.1

    }
    
    private func setConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            favoriteButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25),
            favoriteButton.heightAnchor.constraint(equalTo: favoriteButton.widthAnchor),
            favoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            favoriteButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
        
        addToCartButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addToCartButton.heightAnchor.constraint(equalTo: favoriteButton.heightAnchor),
            addToCartButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            addToCartButton.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -10),
            addToCartButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
}
