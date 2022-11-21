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
    
    let sizeView = UIView()
    let sizeImage = UIImageView(image: Resources.Images.Shop.size)
    let sizeLabel = UILabel()
    let sizeValueLabel = UILabel()
    
    let bottonDetailsStack = UIStackView()
    
    let lightView = UIView()
    let lightImage = UIImageView(image: Resources.Images.Shop.light)
    let lightLabel = UILabel()
    let lightValueLabel = UILabel()
    
    let humidityView = UIView()
    let humidityImage = UIImageView(image: Resources.Images.Shop.humidity)
    let humidityLabel = UILabel()
    let humidityValueLabel = UILabel()
    
    let temperatureView = UIView()
    let temperatureImage = UIImageView(image: Resources.Images.Shop.temperature)
    let temperatureLabel = UILabel()
    let temperatureValueLabel = UILabel()
    
    let originView = UIView()
    let originImage = UIImageView(image: Resources.Images.Shop.origin)
    let originLabel = UILabel()
    let originValueLabel = UILabel()
    
    let bottonView = UIView()
    let priceStackView = UIStackView()
    let priceLabel = UILabel()
    let priceValueLabel = UILabel()
    
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
        
        scrollView.addSubview(detailsStackView)
        
        detailsStackView.addArrangedSubview(upperDetailsStack)
        upperDetailsStack.addArrangedSubview(careLevelView)
        careLevelView.addSubview(careLevelImage)
        careLevelView.addSubview(careLevelLabel)
        careLevelView.addSubview(careValueLabel)
        
        upperDetailsStack.addArrangedSubview(petView)
        petView.addSubview(petFriendlyImage)
        petView.addSubview(petFriendlyLabel)
        petView.addSubview(petValueLabel)
        
        upperDetailsStack.addArrangedSubview(sizeView)
        sizeView.addSubview(sizeImage)
        sizeView.addSubview(sizeLabel)
        sizeView.addSubview(sizeValueLabel)
        
        
        detailsStackView.addArrangedSubview(bottonDetailsStack)
        bottonDetailsStack.addArrangedSubview(lightView)
        lightView.addSubview(lightImage)
        lightView.addSubview(lightLabel)
        lightView.addSubview(lightValueLabel)
        
        bottonDetailsStack.addArrangedSubview(humidityView)
        humidityView.addSubview(humidityImage)
        humidityView.addSubview(humidityLabel)
        humidityView.addSubview(humidityValueLabel)
        
        bottonDetailsStack.addArrangedSubview(temperatureView)
        temperatureView.addSubview(temperatureImage)
        temperatureView.addSubview(temperatureLabel)
        temperatureView.addSubview(temperatureValueLabel)
        
        detailsStackView.addArrangedSubview(originView)
        originView.addSubview(originImage)
        originView.addSubview(originLabel)
        originView.addSubview(originValueLabel)
        
        view.addSubview(bottonView)
        bottonView.addSubview(priceStackView)
        bottonView.addSubview(addToCartButton)
        priceStackView.addSubview(priceLabel)
        priceStackView.addSubview(priceValueLabel)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        upperDetailsStack.distribution = .fillEqually
    }
    
    private func configureViews() {
                
        imageView.image = shopItem.image
        imageView.contentMode = .scaleToFill
        
        nameItem.text = shopItem.name
        nameItem.font = Resources.Fonts.header
        latinNameItem.text = shopItem.latinName
        latinNameItem.font = Resources.Fonts.subHeaders
        latinNameItem.textColor = Resources.Colors.subHeader
        
        descriptionItem.numberOfLines = 0
        descriptionItem.text = shopItem.description
        descriptionItem.font = Resources.Fonts.generalText
        
        // DetailsStackView
        detailsStackView.axis = .vertical
        detailsStackView.distribution = .fillProportionally
        detailsStackView.spacing = 20
        
        upperDetailsStack.axis = .horizontal
        upperDetailsStack.distribution = .fillEqually
        
        careLevelLabel.text = Resources.Strings.Shop.Detail.careLevel
        careLevelLabel.font = Resources.Fonts.subHeaders
        careLevelLabel.textColor = Resources.Colors.subHeader
        careValueLabel.text = shopItem.careLevel
        careValueLabel.font = Resources.Fonts.values
        
        petFriendlyLabel.text = Resources.Strings.Shop.Detail.petFriendly
        petFriendlyLabel.font = Resources.Fonts.subHeaders
        petFriendlyLabel.textColor = Resources.Colors.subHeader
        petValueLabel.text = shopItem.petFriendly
        petValueLabel.numberOfLines = 0
        petValueLabel.font = Resources.Fonts.values
        
        sizeLabel.text = Resources.Strings.Shop.Detail.size
        sizeLabel.font = Resources.Fonts.subHeaders
        sizeLabel.textColor = Resources.Colors.subHeader
        var sizeValueText = shopItem.size?.components(separatedBy: ",").map({$0.trimmingCharacters(in: .whitespaces) + "\n"}).joined()
        sizeValueText?.removeLast()
        sizeValueLabel.text = sizeValueText
        sizeValueLabel.numberOfLines = 0
        sizeValueLabel.font = Resources.Fonts.values

        
        bottonDetailsStack.axis = .horizontal
        bottonDetailsStack.distribution = .fillEqually
        
        lightLabel.text = Resources.Strings.Shop.Detail.light
        lightLabel.font = Resources.Fonts.subHeaders
        lightLabel.textColor = Resources.Colors.subHeader
        lightValueLabel.text = shopItem.light
        lightValueLabel.font = Resources.Fonts.values

        
        humidityLabel.text = Resources.Strings.Shop.Detail.humidity
        humidityLabel.font = Resources.Fonts.subHeaders
        humidityLabel.textColor = Resources.Colors.subHeader
        humidityValueLabel.text = shopItem.humidity
        humidityValueLabel.font = Resources.Fonts.values

        temperatureLabel.text = Resources.Strings.Shop.Detail.temperature
        temperatureLabel.font = Resources.Fonts.subHeaders
        temperatureLabel.textColor = Resources.Colors.subHeader
        temperatureValueLabel.text = shopItem.temperature
        temperatureValueLabel.numberOfLines = 0
        temperatureValueLabel.font = Resources.Fonts.values

        
        originLabel.text = Resources.Strings.Shop.Detail.origin
        originLabel.font = Resources.Fonts.subHeaders
        originLabel.textColor = Resources.Colors.subHeader
        originValueLabel.text = shopItem.origin
        originValueLabel.numberOfLines = 0
        originValueLabel.font = Resources.Fonts.generalText

        
        // BottonView
        priceStackView.axis = .vertical
        priceStackView.alignment = .leading
        
        priceLabel.text = Resources.Strings.Shop.price
        priceLabel.font = Resources.Fonts.subHeaders
        priceLabel.textColor = Resources.Colors.subHeader
        priceValueLabel.text = shopItem.price
        priceValueLabel.font = Resources.Fonts.header
        
        addToCartButton.setTitle(Resources.Strings.Shop.addToCart, for: .normal)
        addToCartButton.titleLabel?.font = Resources.Fonts.generalText?.withSize(18)
        
    }
    
    // MARK: - CONSTRAINTS
    
    private func setConstraints() {
    
        let safeArea = view.safeAreaLayoutGuide
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameItem.translatesAutoresizingMaskIntoConstraints = false
        latinNameItem.translatesAutoresizingMaskIntoConstraints = false
        descriptionItem.translatesAutoresizingMaskIntoConstraints = false
        
        detailsStackView.translatesAutoresizingMaskIntoConstraints = false
        upperDetailsStack.translatesAutoresizingMaskIntoConstraints = false
        
        careLevelView.translatesAutoresizingMaskIntoConstraints = false
        careLevelImage.translatesAutoresizingMaskIntoConstraints = false
        careLevelLabel.translatesAutoresizingMaskIntoConstraints = false
        careValueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        petView.translatesAutoresizingMaskIntoConstraints = false
        petFriendlyImage.translatesAutoresizingMaskIntoConstraints = false
        petFriendlyLabel.translatesAutoresizingMaskIntoConstraints = false
        petValueLabel.translatesAutoresizingMaskIntoConstraints = false

        sizeView.translatesAutoresizingMaskIntoConstraints = false
        sizeImage.translatesAutoresizingMaskIntoConstraints = false
        sizeLabel.translatesAutoresizingMaskIntoConstraints = false
        sizeValueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        bottonDetailsStack.translatesAutoresizingMaskIntoConstraints = false
        lightView.translatesAutoresizingMaskIntoConstraints = false
        lightImage.translatesAutoresizingMaskIntoConstraints = false
        lightLabel.translatesAutoresizingMaskIntoConstraints = false
        lightValueLabel.translatesAutoresizingMaskIntoConstraints = false
        humidityView.translatesAutoresizingMaskIntoConstraints = false
        humidityImage.translatesAutoresizingMaskIntoConstraints = false
        humidityLabel.translatesAutoresizingMaskIntoConstraints = false
        humidityValueLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureView.translatesAutoresizingMaskIntoConstraints = false
        temperatureImage.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureValueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        originView.translatesAutoresizingMaskIntoConstraints = false
        originImage.translatesAutoresizingMaskIntoConstraints = false
        originLabel.translatesAutoresizingMaskIntoConstraints = false
        originValueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        bottonView.translatesAutoresizingMaskIntoConstraints = false
        priceStackView.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceValueLabel.translatesAutoresizingMaskIntoConstraints = false
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
            
            detailsStackView.topAnchor.constraint(equalTo: descriptionItem.bottomAnchor, constant: 20),
            detailsStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            detailsStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            detailsStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -10),
            
            // MARK: - Care Level
            
            careLevelImage.topAnchor.constraint(equalTo: careLevelView.topAnchor),
            careLevelImage.leadingAnchor.constraint(equalTo: careLevelView.leadingAnchor),
            
            careLevelLabel.topAnchor.constraint(equalTo: careLevelView.topAnchor, constant: 2),
            careLevelLabel.leadingAnchor.constraint(equalTo: careLevelImage.trailingAnchor, constant: 5),
            
            careValueLabel.topAnchor.constraint(equalTo: careLevelLabel.bottomAnchor, constant: 10),
            careValueLabel.leadingAnchor.constraint(equalTo: careLevelView.leadingAnchor),
            careValueLabel.bottomAnchor.constraint(equalTo: careLevelView.bottomAnchor),
            careValueLabel.widthAnchor.constraint(equalTo: careLevelView.widthAnchor),

            // MARK: - Pet Friendly
            
            petFriendlyImage.topAnchor.constraint(equalTo: petView.topAnchor),
            petFriendlyImage.leadingAnchor.constraint(equalTo: petView.leadingAnchor),
            
            petFriendlyLabel.topAnchor.constraint(equalTo: petView.topAnchor, constant: 2),
            petFriendlyLabel.leadingAnchor.constraint(equalTo: petFriendlyImage.trailingAnchor, constant: 5),
            
            petValueLabel.topAnchor.constraint(equalTo: petFriendlyLabel.bottomAnchor, constant: 10),
            petValueLabel.leadingAnchor.constraint(equalTo: petView.leadingAnchor),
            petValueLabel.bottomAnchor.constraint(equalTo: petView.bottomAnchor),
            petValueLabel.widthAnchor.constraint(equalTo: petView.widthAnchor),

            // MARK: - Size
            
            sizeImage.topAnchor.constraint(equalTo: sizeView.topAnchor),
            sizeImage.leadingAnchor.constraint(equalTo: sizeView.leadingAnchor),
            
            sizeLabel.topAnchor.constraint(equalTo: sizeView.topAnchor, constant: 2),
            sizeLabel.leadingAnchor.constraint(equalTo: sizeImage.trailingAnchor, constant: 5),
            
            sizeValueLabel.topAnchor.constraint(equalTo: sizeLabel.bottomAnchor, constant: 10),
            sizeValueLabel.leadingAnchor.constraint(equalTo: sizeView.leadingAnchor),
            sizeValueLabel.bottomAnchor.constraint(equalTo: sizeView.bottomAnchor),
            sizeValueLabel.widthAnchor.constraint(equalTo: sizeView.widthAnchor),
            
            // MARK: - Light
            
            lightImage.topAnchor.constraint(equalTo: lightView.topAnchor),
            lightImage.leadingAnchor.constraint(equalTo: lightView.leadingAnchor),
            
            lightLabel.topAnchor.constraint(equalTo: lightView.topAnchor, constant: 2),
            lightLabel.leadingAnchor.constraint(equalTo: lightImage.trailingAnchor, constant: 5),
            
            lightValueLabel.topAnchor.constraint(equalTo: lightLabel.bottomAnchor, constant: 10),
            lightValueLabel.leadingAnchor.constraint(equalTo: lightView.leadingAnchor),
            lightValueLabel.bottomAnchor.constraint(equalTo: lightView.bottomAnchor),
            lightValueLabel.widthAnchor.constraint(equalTo: lightView.widthAnchor),

            // MARK: - Humidity
            
            humidityImage.topAnchor.constraint(equalTo: humidityView.topAnchor),
            humidityImage.leadingAnchor.constraint(equalTo: humidityView.leadingAnchor),
            
            humidityLabel.topAnchor.constraint(equalTo: humidityView.topAnchor, constant: 2),
            humidityLabel.leadingAnchor.constraint(equalTo: humidityImage.trailingAnchor, constant: 5),
            
            humidityValueLabel.topAnchor.constraint(equalTo: humidityLabel.bottomAnchor, constant: 10),
            humidityValueLabel.leadingAnchor.constraint(equalTo: humidityView.leadingAnchor),
            humidityValueLabel.bottomAnchor.constraint(equalTo: humidityView.bottomAnchor),
            humidityValueLabel.widthAnchor.constraint(equalTo: humidityView.widthAnchor),

            // MARK: - Temperature
            
            temperatureImage.topAnchor.constraint(equalTo: temperatureView.topAnchor),
            temperatureImage.leadingAnchor.constraint(equalTo: temperatureView.leadingAnchor),
            
            temperatureLabel.topAnchor.constraint(equalTo: temperatureView.topAnchor, constant: 2),
            temperatureLabel.leadingAnchor.constraint(equalTo: temperatureImage.trailingAnchor, constant: 5),
            
            temperatureValueLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 10),
            temperatureValueLabel.leadingAnchor.constraint(equalTo: temperatureView.leadingAnchor),
            temperatureValueLabel.bottomAnchor.constraint(equalTo: temperatureView.bottomAnchor),
            temperatureValueLabel.widthAnchor.constraint(equalTo: temperatureView.widthAnchor),
            
            // MARK: - Origin
            
            originImage.topAnchor.constraint(equalTo: originView.topAnchor),
            originImage.leadingAnchor.constraint(equalTo: originView.leadingAnchor),
            
            originLabel.topAnchor.constraint(equalTo: originView.topAnchor, constant: 2),
            originLabel.leadingAnchor.constraint(equalTo: originImage.trailingAnchor, constant: 5),
            
            originValueLabel.topAnchor.constraint(equalTo: originLabel.bottomAnchor, constant: 10),
            originValueLabel.leadingAnchor.constraint(equalTo: originView.leadingAnchor),
            originValueLabel.bottomAnchor.constraint(equalTo: originView.bottomAnchor),
            originValueLabel.widthAnchor.constraint(equalTo: originView.widthAnchor),
            
            // MARK: - Price and Add to Cart View

            bottonView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottonView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottonView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            bottonView.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.1),
            
            priceStackView.topAnchor.constraint(equalTo: bottonView.topAnchor, constant: 10),
            priceStackView.leadingAnchor.constraint(equalTo: bottonView.leadingAnchor, constant: 20),
            priceStackView.trailingAnchor.constraint(equalTo: addToCartButton.leadingAnchor),
            priceStackView.bottomAnchor.constraint(equalTo: bottonView.bottomAnchor),
            
            priceLabel.topAnchor.constraint(equalTo: priceStackView.topAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: priceStackView.leadingAnchor),
            
            priceValueLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 5),
            priceValueLabel.leadingAnchor.constraint(equalTo: priceStackView.leadingAnchor),
            
            addToCartButton.topAnchor.constraint(equalTo: bottonView.topAnchor, constant: 10),
            addToCartButton.trailingAnchor.constraint(equalTo: bottonView.trailingAnchor, constant: -20),
            addToCartButton.bottomAnchor.constraint(equalTo: bottonView.bottomAnchor),
            addToCartButton.widthAnchor.constraint(equalToConstant: view.frame.width * 0.5)
        ])
    }
}
