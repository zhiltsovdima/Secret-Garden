//
//  ItemDetailController.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 18.11.2022.
//

import UIKit

class ItemDetailController: BaseViewController {
    
    let shopItem: ShopItem
    
    init(_ shopItem: ShopItem) {
        self.shopItem = shopItem
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let imageView = UIImageView()
    let nameItem = UILabel()
    let latinNameItem = UILabel()
    
    let descriptionItem = UILabel()
    
    let bottonStackView = UIStackView()
    let priceStackView = UIStackView()
    let priceStrLabel = UILabel()
    let priceLabel = UILabel()
    
    let addToCartButton = BaseButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        configureViews()
        setConstraints()
    }
    
    private func addViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(imageView)
        contentView.addSubview(nameItem)
        contentView.addSubview(latinNameItem)
        contentView.addSubview(descriptionItem)
        
        view.addSubview(bottonStackView)
        bottonStackView.addSubview(priceStackView)
        bottonStackView.addSubview(addToCartButton)
        priceStackView.addSubview(priceStrLabel)
        priceStackView.addSubview(priceLabel)
    }
    
    private func configureViews() {
        imageView.image = shopItem.image
        imageView.contentMode = .scaleAspectFit
        nameItem.text = shopItem.name
        descriptionItem.text = shopItem.description
        descriptionItem.numberOfLines = 0
        descriptionItem.sizeToFit()
        
        
        priceStrLabel.text = Resources.Strings.Shop.price
        
        priceLabel.text = shopItem.price
        addToCartButton.setTitle(Resources.Strings.Shop.addToCart, for: .normal)
        
    }
    
    private func setConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottonStackView.topAnchor)
        ])
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.widthAnchor.constraint(equalToConstant: view.frame.width),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.33)
        ])
        
        nameItem.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameItem.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            nameItem.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
        ])
        
        descriptionItem.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionItem.topAnchor.constraint(equalTo: nameItem.bottomAnchor, constant: 20),
            descriptionItem.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            descriptionItem.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
        
        
        bottonStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottonStackView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.06),
            bottonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            bottonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            bottonStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
        
        priceStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priceStackView.leadingAnchor.constraint(equalTo: bottonStackView.leadingAnchor),
            priceStackView.trailingAnchor.constraint(equalTo: addToCartButton.trailingAnchor),
            priceStackView.topAnchor.constraint(equalTo: bottonStackView.topAnchor),
            priceStackView.bottomAnchor.constraint(equalTo: bottonStackView.bottomAnchor)
        ])
        
        priceStrLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priceStrLabel.leadingAnchor.constraint(equalTo: priceStackView.leadingAnchor),
            priceStrLabel.topAnchor.constraint(equalTo: priceStackView.topAnchor, constant: 3)
        ])
        
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priceLabel.leadingAnchor.constraint(equalTo: priceStackView.leadingAnchor),
            priceLabel.topAnchor.constraint(equalTo: priceStrLabel.bottomAnchor, constant: 3),
            priceLabel.bottomAnchor.constraint(equalTo: priceStackView.bottomAnchor, constant: -3)
        ])
        
        addToCartButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addToCartButton.trailingAnchor.constraint(equalTo: bottonStackView.trailingAnchor),
            addToCartButton.topAnchor.constraint(equalTo: bottonStackView.topAnchor),
            addToCartButton.bottomAnchor.constraint(equalTo: bottonStackView.bottomAnchor),
            addToCartButton.widthAnchor.constraint(equalToConstant: view.frame.width * 0.5)

        ])
        
    }
    
}
