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
    private let spinner = UIActivityIndicatorView()
    
    private var isFetched: Bool {
        return imageView.image != nil ? true : false
    }
    
    var favoriteCompletion: ((Bool) -> Void)?
    var cartCompletion: (() -> Void)?
    var goToCartCompletion: (() -> Void)?
    
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
        favoriteButton.backgroundColor = item.isFavorite ? .black : Resources.Colors.backgroundColor
        favoriteButton.tintColor = item.isFavorite ? Resources.Colors.backgroundColor : .black
        if item.isAddedToCart {
            addToCartButton.backgroundColor = .black
            addToCartButton.setTitle(Resources.Strings.Shop.added, for: .normal)
            addToCartButton.setTitleColor(Resources.Colors.backgroundColor, for: .normal)
        } else {
            addToCartButton.backgroundColor = Resources.Colors.backgroundColor
            addToCartButton.setTitle(Resources.Strings.Shop.addToCart, for: .normal)
            addToCartButton.setTitleColor(.black, for: .normal)
        }
        if isFetched {
            spinner.stopAnimating()
        } else {
            spinner.startAnimating()
        }
        
    }
    
    override func layoutSubviews() {
        favoriteButton.layer.cornerRadius = favoriteButton.frame.height * 0.5
        addToCartButton.layer.cornerRadius = addToCartButton.frame.height * 0.5
    }
    
    @objc private func addToFavorites() {
        
        if favoriteButton.backgroundColor == Resources.Colors.backgroundColor {
            favoriteButton.backgroundColor = .black
            favoriteButton.tintColor = Resources.Colors.backgroundColor
            favoriteCompletion?(true)
        } else {
            favoriteButton.backgroundColor = Resources.Colors.backgroundColor
            favoriteButton.tintColor = .black
            favoriteCompletion?(false)
        }
    }
    
    @objc private func addToCart() {
        
        guard addToCartButton.backgroundColor == Resources.Colors.backgroundColor else { goToCartCompletion?(); return }
        addToCartButton.backgroundColor = .black
        addToCartButton.setTitle(Resources.Strings.Shop.added, for: .normal)
        addToCartButton.setTitleColor(Resources.Colors.backgroundColor, for: .normal)
        cartCompletion?()
    }
    
    private func configure() {
        
        addSubview(imageView)
        addSubview(spinner)

        contentView.addSubview(favoriteButton)
        favoriteButton.setImage(Resources.Images.Common.addToFavorite, for: .normal)
        
        favoriteButton.layer.borderWidth = 0.1
        favoriteButton.addTarget(self, action: #selector(addToFavorites), for: .touchUpInside)
        
        contentView.addSubview(addToCartButton)
        addToCartButton.setTitle(Resources.Strings.Shop.addToCart, for: .normal)
        addToCartButton.setTitleColor(.black, for: .normal)
        addToCartButton.titleLabel?.font = Resources.Fonts.general?.withSize(13)
        addToCartButton.backgroundColor = Resources.Colors.backgroundColor
        addToCartButton.layer.borderWidth = 0.1
        addToCartButton.addTarget(self, action: #selector(addToCart), for: .touchUpInside)

    }
    
    private func setConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor)
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
