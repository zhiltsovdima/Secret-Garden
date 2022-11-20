//
//  ItemDetailController.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 18.11.2022.
//

import UIKit

class ItemDetailController: BaseViewController {
    
    let shopItem: ShopItem
    
    let scrollView = UIScrollView()
    
    let imageView = UIImageView()
    let nameItem = UILabel()
    let latinNameItem = UILabel()
    let descriptionItem = UILabel()
    
    let bottonView = UIView()
    let priceStackView = UIStackView()
    let priceStrLabel = UILabel()
    let priceLabel = UILabel()
    
    let addToCartButton = BaseButton()
    
    let testLabel = UILabel()
    
    init(_ shopItem: ShopItem) {
        self.shopItem = shopItem
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        
        addViews()
        configureViews()
        setConstraints()
    }

    private func addViews() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(imageView)
        scrollView.addSubview(nameItem)
        scrollView.addSubview(latinNameItem)
        scrollView.addSubview(descriptionItem)
        
        view.addSubview(bottonView)
        bottonView.addSubview(priceStackView)
        bottonView.addSubview(addToCartButton)
        priceStackView.addSubview(priceStrLabel)
        priceStackView.addSubview(priceLabel)
    }
    
    private func configureViews() {
                
        imageView.image = shopItem.image
        imageView.contentMode = .scaleToFill
        
        nameItem.text = shopItem.name
        latinNameItem.text = shopItem.latinName
        
        descriptionItem.numberOfLines = 0
        descriptionItem.text = shopItem.description
        
        priceStackView.axis = .vertical
        priceStackView.alignment = .leading
        priceStackView.spacing = 10
        
        priceStrLabel.text = Resources.Strings.Shop.price
        priceLabel.text = shopItem.price
        
        addToCartButton.setTitle(Resources.Strings.Shop.addToCart, for: .normal)
        
    }
    
    private func setConstraints() {
    
        let safeArea = view.safeAreaLayoutGuide
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameItem.translatesAutoresizingMaskIntoConstraints = false
        latinNameItem.translatesAutoresizingMaskIntoConstraints = false
        descriptionItem.translatesAutoresizingMaskIntoConstraints = false
        bottonView.translatesAutoresizingMaskIntoConstraints = false
        priceStackView.translatesAutoresizingMaskIntoConstraints = false
        priceStrLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        addToCartButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottonView.topAnchor),
            
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30),
            imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -30),
            imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -60),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.25),
            
            nameItem.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            nameItem.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            
            latinNameItem.topAnchor.constraint(equalTo: nameItem.bottomAnchor),
            latinNameItem.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            
            descriptionItem.topAnchor.constraint(equalTo: latinNameItem.bottomAnchor, constant: 20),
            descriptionItem.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            descriptionItem.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor,constant: -20),
            descriptionItem.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            descriptionItem.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40),
            
            bottonView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottonView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottonView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            bottonView.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.1),
            
            priceStackView.topAnchor.constraint(equalTo: bottonView.topAnchor, constant: 10),
            priceStackView.leadingAnchor.constraint(equalTo: bottonView.leadingAnchor, constant: 20),
            priceStackView.trailingAnchor.constraint(equalTo: addToCartButton.leadingAnchor),
            priceStackView.bottomAnchor.constraint(equalTo: bottonView.bottomAnchor),
            
            priceStrLabel.topAnchor.constraint(equalTo: priceStackView.topAnchor),
            priceStrLabel.leadingAnchor.constraint(equalTo: priceStackView.leadingAnchor),
            
            priceLabel.topAnchor.constraint(equalTo: priceStrLabel.bottomAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: priceStackView.leadingAnchor),
            
            addToCartButton.topAnchor.constraint(equalTo: bottonView.topAnchor, constant: 10),
            addToCartButton.trailingAnchor.constraint(equalTo: bottonView.trailingAnchor, constant: -20),
            addToCartButton.bottomAnchor.constraint(equalTo: bottonView.bottomAnchor),
            addToCartButton.widthAnchor.constraint(equalToConstant: view.frame.width * 0.5)
        ])
    }
}
