//
//  FavoriteCell.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 22.11.2022.
//

import UIKit

struct FavoriteCellModel {
    var id: Int
    var name: String
    var price: String
    var image: UIImage?
}

final class FavoriteCell: UITableViewCell {
    
    private var model: FavoriteCellModel?
    
    private let priceLabel = UILabel()
    private let nameItem = UILabel()
    private let itemImageView = UIImageView()
    private let favoriteButton = UIButton()
    
    var unfavoriteCompletion: ((UITableViewCell) -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with model: FavoriteCellModel) {
        self.model = model
        nameItem.text = model.name
        priceLabel.text = model.price
        itemImageView.image = model.image
    }
    
    @objc private func unfavItemAction() {
        unfavoriteCompletion?(self)
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        backgroundColor = Resources.Colors.backgroundColor

        addSubview(itemImageView)
        addSubview(priceLabel)
        addSubview(nameItem)
        contentView.addSubview(favoriteButton)
        
        itemImageView.layer.cornerRadius = 10
        itemImageView.clipsToBounds = true
        itemImageView.contentMode = .scaleAspectFill
 
        nameItem.numberOfLines = 0
        nameItem.font = Resources.Fonts.general
        
        priceLabel.numberOfLines = 0
        priceLabel.font = Resources.Fonts.generalBold
        
        favoriteButton.addTarget(self, action: #selector(unfavItemAction), for: .touchUpInside)
        favoriteButton.setImage(Resources.Images.Common.addToFavoriteFill, for: .normal)
        favoriteButton.tintColor = Resources.Colors.blackOnWhite
        makeSystemAnimation(for: favoriteButton)
    }
    
    private func setupConstraints() {
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        nameItem.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            itemImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            itemImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            itemImageView.widthAnchor.constraint(equalToConstant: 130),
            itemImageView.heightAnchor.constraint(equalToConstant: 130),
        
            nameItem.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            nameItem.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 10),
            nameItem.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -30),
            
            priceLabel.topAnchor.constraint(equalTo: nameItem.bottomAnchor, constant: 5),
            priceLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 10),
            
            favoriteButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            favoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)

        ])
    }
    
}
