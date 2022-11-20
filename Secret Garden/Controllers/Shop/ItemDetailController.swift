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
    
    let detailsStackView = UIStackView()
    let upperDetailsStack = UIStackView()
    
    let careLevelView = UIView()
    let careLevelImage = UIImageView(image: Resources.Images.Shop.careLevel)
    let careLevelLabel = UILabel()
    let careValueLabel = UILabel()
    
    let petView = UIView()
    let petFriendlyImage = UIImageView(image: Resources.Images.Shop.petFriendly)
    let petFriendlyLabel = UILabel()
    let petValueLabel = UILabel()
    
    let originView = UIView()
    let originImage = UIImageView(image: Resources.Images.Shop.origin)
    let originLabel = UILabel()
    let originValueLabel = UILabel()



    
    let bottonView = UIView()
    let priceStackView = UIStackView()
    let priceStrLabel = UILabel()
    let priceLabel = UILabel()
    
    let addToCartButton = BaseButton()
    
    
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
        
        scrollView.addSubview(upperDetailsStack)
        upperDetailsStack.addSubview(careLevelView)
        careLevelView.addSubview(careLevelImage)
        careLevelView.addSubview(careLevelLabel)
        careLevelView.addSubview(careValueLabel)
        
        upperDetailsStack.addSubview(petView)
        petView.addSubview(petFriendlyImage)
        petView.addSubview(petFriendlyLabel)
        petView.addSubview(petValueLabel)
        
        upperDetailsStack.addSubview(originView)
        originView.addSubview(originImage)
        originView.addSubview(originLabel)
        originView.addSubview(originValueLabel)
        
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
        
        upperDetailsStack.axis = .horizontal
        upperDetailsStack.distribution = .fillEqually
        
        careLevelLabel.text = Resources.Strings.Shop.Detail.careLevel
        careValueLabel.text = shopItem.careLevel
        
        petFriendlyLabel.text = Resources.Strings.Shop.Detail.petFriendly
        petValueLabel.text = shopItem.petFriendly
        petValueLabel.numberOfLines = 0
        
        originLabel.text = Resources.Strings.Shop.Detail.origin
        originValueLabel.text = shopItem.origin
        originValueLabel.numberOfLines = 0
        
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
        
        upperDetailsStack.translatesAutoresizingMaskIntoConstraints = false
        careLevelView.translatesAutoresizingMaskIntoConstraints = false
        careLevelImage.translatesAutoresizingMaskIntoConstraints = false
        careLevelLabel.translatesAutoresizingMaskIntoConstraints = false
        careValueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        petView.translatesAutoresizingMaskIntoConstraints = false
        petFriendlyImage.translatesAutoresizingMaskIntoConstraints = false
        petFriendlyLabel.translatesAutoresizingMaskIntoConstraints = false
        petValueLabel.translatesAutoresizingMaskIntoConstraints = false

        originView.translatesAutoresizingMaskIntoConstraints = false
        originImage.translatesAutoresizingMaskIntoConstraints = false
        originLabel.translatesAutoresizingMaskIntoConstraints = false
        originValueLabel.translatesAutoresizingMaskIntoConstraints = false

        
        bottonView.translatesAutoresizingMaskIntoConstraints = false
        priceStackView.translatesAutoresizingMaskIntoConstraints = false
        priceStrLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        addToCartButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            // MARK: - ScrollView
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
            descriptionItem.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40),
            
            // MARK: - DetailsStackView
            
            upperDetailsStack.topAnchor.constraint(equalTo: descriptionItem.bottomAnchor, constant: 20),
            upperDetailsStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            upperDetailsStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            upperDetailsStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            upperDetailsStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40),
            upperDetailsStack.heightAnchor.constraint(equalToConstant: 80.0),
            
            // MARK: - CareLevelView
            
            careLevelView.topAnchor.constraint(equalTo: upperDetailsStack.topAnchor),
            careLevelView.leadingAnchor.constraint(equalTo: upperDetailsStack.leadingAnchor),
            careLevelView.bottomAnchor.constraint(equalTo: upperDetailsStack.bottomAnchor),
            careLevelView.widthAnchor.constraint(equalTo: upperDetailsStack.widthAnchor, multiplier: 1/3),
            
            careLevelImage.topAnchor.constraint(equalTo: careLevelView.topAnchor),
            careLevelImage.leadingAnchor.constraint(equalTo: careLevelView.leadingAnchor),
            
            careLevelLabel.topAnchor.constraint(equalTo: careLevelView.topAnchor),
            careLevelLabel.leadingAnchor.constraint(equalTo: careLevelImage.trailingAnchor, constant: 5),
            
            careValueLabel.topAnchor.constraint(equalTo: careLevelLabel.bottomAnchor),
            careValueLabel.leadingAnchor.constraint(equalTo: careLevelView.leadingAnchor),
            careValueLabel.bottomAnchor.constraint(equalTo: careLevelView.bottomAnchor),
            careValueLabel.widthAnchor.constraint(equalTo: careLevelView.widthAnchor),

            // MARK: - PetView
            
            petView.topAnchor.constraint(equalTo: upperDetailsStack.topAnchor),
            petView.leadingAnchor.constraint(equalTo: careLevelView.trailingAnchor),
            petView.bottomAnchor.constraint(equalTo: upperDetailsStack.bottomAnchor),
            petView.widthAnchor.constraint(equalTo: upperDetailsStack.widthAnchor, multiplier: 1/3),
            
            petFriendlyImage.topAnchor.constraint(equalTo: petView.topAnchor),
            petFriendlyImage.leadingAnchor.constraint(equalTo: petView.leadingAnchor),
            
            petFriendlyLabel.topAnchor.constraint(equalTo: petView.topAnchor),
            petFriendlyLabel.leadingAnchor.constraint(equalTo: petFriendlyImage.trailingAnchor, constant: 5),
            
            petValueLabel.topAnchor.constraint(equalTo: petFriendlyLabel.bottomAnchor),
            petValueLabel.leadingAnchor.constraint(equalTo: petView.leadingAnchor),
            petValueLabel.bottomAnchor.constraint(equalTo: petView.bottomAnchor),
            petValueLabel.widthAnchor.constraint(equalTo: petView.widthAnchor),



            // MARK: - OriginView

            originView.topAnchor.constraint(equalTo: upperDetailsStack.topAnchor),
            originView.leadingAnchor.constraint(equalTo: petView.trailingAnchor),
            originView.trailingAnchor.constraint(equalTo: upperDetailsStack.trailingAnchor),
            originView.bottomAnchor.constraint(equalTo: upperDetailsStack.bottomAnchor),
            originView.widthAnchor.constraint(equalTo: upperDetailsStack.widthAnchor, multiplier: 1/3),
            
            originImage.topAnchor.constraint(equalTo: originView.topAnchor),
            originImage.leadingAnchor.constraint(equalTo: originView.leadingAnchor),
            
            originLabel.topAnchor.constraint(equalTo: originView.topAnchor),
            originLabel.leadingAnchor.constraint(equalTo: originImage.trailingAnchor, constant: 5),
            
            originValueLabel.topAnchor.constraint(equalTo: originLabel.bottomAnchor),
            originValueLabel.leadingAnchor.constraint(equalTo: originView.leadingAnchor),
            originValueLabel.bottomAnchor.constraint(equalTo: originView.bottomAnchor),
            originValueLabel.widthAnchor.constraint(equalTo: originView.widthAnchor),

            // MARK: - BottonStackView

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
