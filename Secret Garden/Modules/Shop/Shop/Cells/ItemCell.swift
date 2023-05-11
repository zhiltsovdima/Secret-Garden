//
//  ItemCell.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 12.11.2022.
//

import UIKit

class ShopItemCellModel {
    var id: String
    var name: String
    var image: UIImage?
    var isFavorite: Bool
    var isAddedToCart: Bool
    
    init(id: String, name: String, image: UIImage? = nil, isFavorite: Bool, isAddedToCart: Bool) {
        self.id = id
        self.name = name
        self.image = image
        self.isFavorite = isFavorite
        self.isAddedToCart = isAddedToCart
    }
}

final class ItemCell: UICollectionViewCell {
        
    private var model: ShopItemCellModel?
        
    private var imageView = UIImageView()
    private var name: String?
    private let favoriteButton = UIButton()
    private let addToCartButton = UIButton()
    private let spinner = UIActivityIndicatorView()
    
    var favoriteCompletion: ((String) -> Void)?
    var cartCompletion: ((String) -> Void)?
    var goToCartCompletion: (() -> Void)?
    var updateCellCompletion: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        favoriteButton.layer.cornerRadius = favoriteButton.frame.height * 0.5
        addToCartButton.layer.cornerRadius = addToCartButton.frame.height * 0.5
    }
    
    func setup(with model: ShopItemCellModel) {
        self.model = model
        name = model.name
        setupImage()
        setFavoriteButtonAppearance()
        setCartButtonAppearance()
    }
    
    private func setupImage() {
        if let image = model?.image {
            imageView.image = image
            spinner.stopAnimating()
            isUserInteractionEnabled = true
            addToCartButton.isHidden = false
            favoriteButton.isHidden = false
        } else {
            imageView.image = nil
            spinner.startAnimating()
            isUserInteractionEnabled = false
            addToCartButton.isHidden = true
            favoriteButton.isHidden = true
        }

    }
    
    @objc private func changeFavorite() {
        guard let model else { return }
        favoriteCompletion?(model.id)
    }
    
    @objc private func addToCart() {
        guard let model else { return }
        let isAdded = model.isAddedToCart
        guard !isAdded else { goToCartCompletion?(); return }
        cartCompletion?(model.id)
    }
    
    // MARK: - Update Buttons
    private func setFavoriteButtonAppearance() {
        guard let isFavorite = model?.isFavorite else { return }
        if isFavorite {
            favoriteButton.backgroundColor = Resources.Colors.shopButton
            favoriteButton.tintColor = .white
        } else {
            favoriteButton.backgroundColor = Resources.Colors.backgroundColor
            favoriteButton.tintColor = Resources.Colors.blackOnWhite
        }
    }
    
    private func setCartButtonAppearance() {
        guard let isAdded = model?.isAddedToCart else { return }
        if isAdded {
            addToCartButton.backgroundColor = Resources.Colors.shopButton
            addToCartButton.setTitle(Resources.Strings.Shop.added, for: .normal)
            addToCartButton.setTitleColor(.white, for: .normal)
        } else {
            addToCartButton.backgroundColor = Resources.Colors.backgroundColor
            addToCartButton.setTitle(Resources.Strings.Shop.addToCart, for: .normal)
            addToCartButton.setTitleColor(Resources.Colors.blackOnWhite, for: .normal)
        }
    }
    
    // MARK: - Views Settings

    private func setupViews() {
        addSubview(imageView)
        addSubview(spinner)
        spinner.hidesWhenStopped = true
        
        contentView.addSubview(favoriteButton)
        favoriteButton.setImage(Resources.Images.Common.addToFavorite, for: .normal)
        
        favoriteButton.layer.borderWidth = 0.1
        favoriteButton.addTarget(self, action: #selector(changeFavorite), for: .touchUpInside)
        
        contentView.addSubview(addToCartButton)
        addToCartButton.setTitle(Resources.Strings.Shop.addToCart, for: .normal)
        addToCartButton.setTitleColor(.black, for: .normal)
        addToCartButton.titleLabel?.font = Font.generalBold.withSize(12)
        addToCartButton.backgroundColor = Resources.Colors.backgroundColor
        addToCartButton.layer.borderWidth = 0.1
        addToCartButton.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
        
    }
    
    private func setupConstraints() {
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
