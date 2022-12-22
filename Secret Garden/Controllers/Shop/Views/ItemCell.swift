//
//  ItemCell.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 12.11.2022.
//

import UIKit

final class ItemCell: UICollectionViewCell {
    
    private var shopItem: ShopItem?
        
    private var imageView = UIImageView()
    private var name: String?
    private let favoriteButton = UIButton()
    private let addToCartButton = UIButton()
    private let spinner = UIActivityIndicatorView()
    
    var favoriteCompletion: (() -> Void)?
    var cartCompletion: (() -> Void)?
    var goToCartCompletion: (() -> Void)?
    var updateCellCompletion: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        favoriteButton.layer.cornerRadius = favoriteButton.frame.height * 0.5
        addToCartButton.layer.cornerRadius = addToCartButton.frame.height * 0.5
    }
    
    func setItem(_ item: ShopItem) {
        shopItem = item
        setFavoriteButtonAppearance()
        setCartButtonAppearance()
        
        item.downloadData { fetchedImage in
            DispatchQueue.main.async {
                self.imageView.image = fetchedImage
                self.spinner.stopAnimating()
                self.spinner.isHidden = true
            }
        }
    }
    
    @objc private func changeFavorite() {
        favoriteCompletion?()
    }
    
    @objc private func addToCart() {
        guard let isAdded = shopItem?.isAddedToCart else { return }
        guard !isAdded else { goToCartCompletion?(); return }
        cartCompletion?()
    }
    
    // MARK: - Update Buttons
    private func setFavoriteButtonAppearance() {
        guard let isFavorite = shopItem?.isFavorite else { return }
        if isFavorite {
            favoriteButton.backgroundColor = .black
            favoriteButton.tintColor = Resources.Colors.backgroundColor
        } else {
            favoriteButton.backgroundColor = Resources.Colors.backgroundColor
            favoriteButton.tintColor = .black
        }
    }
    
    private func setCartButtonAppearance() {
        guard let isAdded = shopItem?.isAddedToCart else { return }
        if isAdded {
            addToCartButton.backgroundColor = .black
            addToCartButton.setTitle(Resources.Strings.Shop.added, for: .normal)
            addToCartButton.setTitleColor(Resources.Colors.backgroundColor, for: .normal)
        } else {
            addToCartButton.backgroundColor = Resources.Colors.backgroundColor
            addToCartButton.setTitle(Resources.Strings.Shop.addToCart, for: .normal)
            addToCartButton.setTitleColor(.black, for: .normal)
        }
    }
    
    // MARK: - Configure Views
    private func configure() {
        
        addSubview(imageView)
        addSubview(spinner)
        spinner.startAnimating()

        contentView.addSubview(favoriteButton)
        favoriteButton.setImage(Resources.Images.Common.addToFavorite, for: .normal)
        
        favoriteButton.layer.borderWidth = 0.1
        favoriteButton.addTarget(self, action: #selector(changeFavorite), for: .touchUpInside)
        
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
        spinner.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        addToCartButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),

            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),

            favoriteButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25),
            favoriteButton.heightAnchor.constraint(equalTo: favoriteButton.widthAnchor),
            favoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            favoriteButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),

            addToCartButton.heightAnchor.constraint(equalTo: favoriteButton.heightAnchor),
            addToCartButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            addToCartButton.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -10),
            addToCartButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
}
