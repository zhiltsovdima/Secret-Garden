//
//  CartCell.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 26.11.2022.
//

import UIKit

final class CartCell: UITableViewCell {
    
    private let priceLabel = UILabel()
    private let nameItem = UILabel()
    private let itemImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        configureViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCart(with item: ShopItem) {
        nameItem.text = item.name
        priceLabel.text = item.price
        itemImageView.image = item.image
    }
    
    private func setupViews() {
        addSubview(itemImageView)
        addSubview(priceLabel)
        addSubview(nameItem)

    }
    private func configureViews() {
        itemImageView.layer.cornerRadius = 10
        itemImageView.clipsToBounds = true
        itemImageView.contentMode = .scaleAspectFill
 
        nameItem.numberOfLines = 0
        nameItem.font = Resources.Fonts.general
        
        priceLabel.numberOfLines = 0
        priceLabel.font = Resources.Fonts.generalBold
        
    }
    
    private func setConstraints() {
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        nameItem.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            itemImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            itemImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            itemImageView.widthAnchor.constraint(equalToConstant: 130),
            itemImageView.heightAnchor.constraint(equalToConstant: 130),
        
            nameItem.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            nameItem.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 10),
            nameItem.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            
            priceLabel.topAnchor.constraint(equalTo: nameItem.bottomAnchor, constant: 20),
            priceLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 10),
            
        ])
    }
    
}
