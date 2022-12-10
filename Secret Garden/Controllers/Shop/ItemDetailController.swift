//
//  ItemDetailController.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 18.11.2022.
//

import UIKit

class ItemDetailController: BaseViewController {
    
    var shopItem: ShopItem {
        didSet {
            setButtons()
        }
    }
    
    private let scrollView = UIScrollView()
    
    private var favoriteImage: UIImage? {
        shopItem.isFavorite ? Resources.Images.Common.addToFavoriteFill : Resources.Images.Common.addToFavorite
    }
    
    private let imageView = UIImageView()
    private let nameItem = UILabel()
    private let latinNameItem = UILabel()
    private let descriptionItem = UILabel()
    
    private let detailsStackView = UIStackView()
    private let upperDetailsStack = UIStackView()
    
    private let careLevelView = UIView()
    private let careLevelImage = UIImageView(image: Resources.Images.Characteristics.careLevel)
    private let careLevelLabel = UILabel()
    private let careValueLabel = UILabel()
    
    private let petView = UIView()
    private let petFriendlyImage = UIImageView(image: Resources.Images.Characteristics.petFriendly)
    private let petFriendlyLabel = UILabel()
    private let petValueLabel = UILabel()
    
    private let sizeView = UIView()
    private let sizeImage = UIImageView(image: Resources.Images.Characteristics.size)
    private let sizeLabel = UILabel()
    private let sizeValueLabel = UILabel()
    
    private let bottonDetailsStack = UIStackView()
    
    private let lightView = UIView()
    private let lightImage = UIImageView(image: Resources.Images.Characteristics.light)
    private let lightLabel = UILabel()
    private let lightValueLabel = UILabel()
    
    private let humidityView = UIView()
    private let humidityImage = UIImageView(image: Resources.Images.Characteristics.humidity)
    private let humidityLabel = UILabel()
    private let humidityValueLabel = UILabel()
    
    private let temperatureView = UIView()
    private let temperatureImage = UIImageView(image: Resources.Images.Characteristics.temperature)
    private let temperatureLabel = UILabel()
    private let temperatureValueLabel = UILabel()
    
    private let originView = UIView()
    private let originImage = UIImageView(image: Resources.Images.Characteristics.origin)
    private let originLabel = UILabel()
    private let originValueLabel = UILabel()
    
    private let bottonView = UIView()
    private let priceStackView = UIStackView()
    private let priceLabel = UILabel()
    private let priceValueLabel = UILabel()
    
    private let addToCartButton = BaseButton()
    
    var favoriteCompletion: ((Bool) -> Void)?
    var cartCompletion: (() -> Void)?
    var goToCartCompletion: (() -> Void)?
    

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
        
        addNavBarButton()
        addViews()
        configureViews()
        setConstraints()
    }
    
    private func setButtons() {
        if shopItem.isAddedToCart {
            addToCartButton.setTitle(Resources.Strings.Shop.added, for: .normal)
            addToCartButton.backgroundColor = .black

        } else {
            addToCartButton.setTitle(Resources.Strings.Shop.addToCart, for: .normal)
            addToCartButton.backgroundColor = Resources.Colors.accent
        }
        
        navigationItem.rightBarButtonItem?.image = favoriteImage
    }
    
    private func addNavBarButton() {
        let button = UIBarButtonItem(image: favoriteImage, style: .done, target: self, action: #selector(addToFavorite))
        navigationItem.rightBarButtonItem = button
    }
    
    @objc private func addToFavorite() {
        if navigationItem.rightBarButtonItem?.image == Resources.Images.Common.addToFavorite {
            navigationItem.rightBarButtonItem?.image = Resources.Images.Common.addToFavoriteFill
            favoriteCompletion?(true)
        } else {
            navigationItem.rightBarButtonItem?.image = Resources.Images.Common.addToFavorite
            favoriteCompletion?(false)
        }
    }
    
    @objc private func addToCartAction() {
        guard addToCartButton.backgroundColor == Resources.Colors.accent else { goToCartCompletion?(); return }
        addToCartButton.backgroundColor = .black
        addToCartButton.setTitle(Resources.Strings.Shop.added, for: .normal)
        cartCompletion?()
    }

    private func addViews() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(imageView)
        scrollView.addSubview(nameItem)
        scrollView.addSubview(latinNameItem)
        scrollView.addSubview(descriptionItem)
        
        scrollView.addSubview(detailsStackView)
        
        detailsStackView.addArrangedSubview(upperDetailsStack)
        detailsStackView.addArrangedSubview(bottonDetailsStack)
        detailsStackView.addArrangedSubview(originView)
        
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
        
        originView.addSubview(originImage)
        originView.addSubview(originLabel)
        originView.addSubview(originValueLabel)
        
        view.addSubview(bottonView)
        bottonView.addSubview(priceStackView)
        bottonView.addSubview(addToCartButton)
        priceStackView.addSubview(priceLabel)
        priceStackView.addSubview(priceValueLabel)
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
        descriptionItem.font = Resources.Fonts.general
        
        // DetailsStackView
        detailsStackView.axis = .vertical
        detailsStackView.distribution = .fillProportionally
        detailsStackView.spacing = 20
        
        upperDetailsStack.axis = .horizontal
        upperDetailsStack.distribution = .fillEqually
        
        careLevelLabel.text = Resources.Strings.Common.Detail.careLevel
        careLevelLabel.font = Resources.Fonts.subHeaders
        careLevelLabel.textColor = Resources.Colors.subHeader
        careLevelLabel.numberOfLines = 0
        careValueLabel.text = shopItem.careLevel
        careValueLabel.font = Resources.Fonts.generalBold
        careValueLabel.numberOfLines = 0

        
        petFriendlyLabel.text = Resources.Strings.Common.Detail.petFriendly
        petFriendlyLabel.font = Resources.Fonts.subHeaders
        petFriendlyLabel.textColor = Resources.Colors.subHeader
        petFriendlyLabel.numberOfLines = 0
        petValueLabel.text = shopItem.petFriendly
        petValueLabel.font = Resources.Fonts.generalBold
        petValueLabel.numberOfLines = 0
        
        sizeLabel.text = Resources.Strings.Common.Detail.size
        sizeLabel.font = Resources.Fonts.subHeaders
        sizeLabel.textColor = Resources.Colors.subHeader
        sizeLabel.numberOfLines = 0
        var sizeValueText = shopItem.size?.components(separatedBy: ",").map({$0.trimmingCharacters(in: .whitespaces) + "\n"}).joined()
        sizeValueText?.removeLast()
        sizeValueLabel.text = sizeValueText
        sizeValueLabel.font = Resources.Fonts.generalBold
        sizeValueLabel.numberOfLines = 0
        
        bottonDetailsStack.axis = .horizontal
        bottonDetailsStack.distribution = .fillEqually
        
        lightLabel.text = Resources.Strings.Common.Detail.light
        lightLabel.font = Resources.Fonts.subHeaders
        lightLabel.textColor = Resources.Colors.subHeader
        lightLabel.numberOfLines = 0
        lightValueLabel.text = shopItem.light
        lightValueLabel.font = Resources.Fonts.generalBold
        lightValueLabel.numberOfLines = 0

        humidityLabel.text = Resources.Strings.Common.Detail.humidity
        humidityLabel.font = Resources.Fonts.subHeaders
        humidityLabel.textColor = Resources.Colors.subHeader
        humidityLabel.numberOfLines = 0
        humidityValueLabel.text = shopItem.humidity
        humidityValueLabel.font = Resources.Fonts.generalBold
        humidityValueLabel.numberOfLines = 0

        temperatureLabel.text = Resources.Strings.Common.Detail.temperature
        temperatureLabel.font = Resources.Fonts.subHeaders
        temperatureLabel.textColor = Resources.Colors.subHeader
        temperatureLabel.numberOfLines = 0
        temperatureValueLabel.text = shopItem.temperature
        temperatureValueLabel.font = Resources.Fonts.generalBold
        temperatureValueLabel.numberOfLines = 0
        
        originLabel.text = Resources.Strings.Common.Detail.origin
        originLabel.font = Resources.Fonts.subHeaders
        originLabel.textColor = Resources.Colors.subHeader
        originLabel.numberOfLines = 0
        originValueLabel.text = shopItem.origin
        originValueLabel.font = Resources.Fonts.general
        originValueLabel.numberOfLines = 0

        
        // BottonView
        priceStackView.axis = .vertical
        priceStackView.alignment = .leading
        
        priceLabel.text = Resources.Strings.Shop.price
        priceLabel.font = Resources.Fonts.subHeaders
        priceLabel.textColor = Resources.Colors.subHeader
        priceValueLabel.text = shopItem.price
        priceValueLabel.font = Resources.Fonts.header
        
        setButtons()
        
        addToCartButton.titleLabel?.font = Resources.Fonts.general?.withSize(18)
        addToCartButton.addTarget(self, action: #selector(addToCartAction), for: .touchUpInside)
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
        
        careLevelImage.translatesAutoresizingMaskIntoConstraints = false
        careLevelLabel.translatesAutoresizingMaskIntoConstraints = false
        careValueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        petFriendlyImage.translatesAutoresizingMaskIntoConstraints = false
        petFriendlyLabel.translatesAutoresizingMaskIntoConstraints = false
        petValueLabel.translatesAutoresizingMaskIntoConstraints = false

        sizeImage.translatesAutoresizingMaskIntoConstraints = false
        sizeLabel.translatesAutoresizingMaskIntoConstraints = false
        sizeValueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        lightImage.translatesAutoresizingMaskIntoConstraints = false
        lightLabel.translatesAutoresizingMaskIntoConstraints = false
        lightValueLabel.translatesAutoresizingMaskIntoConstraints = false

        humidityImage.translatesAutoresizingMaskIntoConstraints = false
        humidityLabel.translatesAutoresizingMaskIntoConstraints = false
        humidityValueLabel.translatesAutoresizingMaskIntoConstraints = false

        temperatureImage.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureValueLabel.translatesAutoresizingMaskIntoConstraints = false
        
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
            
            nameItem.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
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
            careValueLabel.heightAnchor.constraint(equalTo: petValueLabel.heightAnchor),

            // MARK: - Pet Friendly
            
            petFriendlyImage.topAnchor.constraint(equalTo: petView.topAnchor),
            petFriendlyImage.leadingAnchor.constraint(equalTo: petView.leadingAnchor),
            
            petFriendlyLabel.topAnchor.constraint(equalTo: petView.topAnchor, constant: 2),
            petFriendlyLabel.leadingAnchor.constraint(equalTo: petFriendlyImage.trailingAnchor, constant: 5),
            
            petValueLabel.topAnchor.constraint(equalTo: petFriendlyLabel.bottomAnchor, constant: 10),
            petValueLabel.leadingAnchor.constraint(equalTo: petView.leadingAnchor),
            petValueLabel.bottomAnchor.constraint(equalTo: petView.bottomAnchor),
            petValueLabel.widthAnchor.constraint(equalTo: petView.widthAnchor),
            petValueLabel.heightAnchor.constraint(equalTo: sizeValueLabel.heightAnchor),

            // MARK: - Size
            
            sizeImage.topAnchor.constraint(equalTo: sizeView.topAnchor),
            sizeImage.leadingAnchor.constraint(equalTo: sizeView.leadingAnchor),
            
            sizeLabel.topAnchor.constraint(equalTo: sizeView.topAnchor, constant: 2),
            sizeLabel.leadingAnchor.constraint(equalTo: sizeImage.trailingAnchor, constant: 5),
            
            sizeValueLabel.topAnchor.constraint(equalTo: sizeLabel.bottomAnchor, constant: 10),
            sizeValueLabel.leadingAnchor.constraint(equalTo: sizeView.leadingAnchor),
            sizeValueLabel.bottomAnchor.constraint(equalTo: sizeView.bottomAnchor),
            sizeValueLabel.widthAnchor.constraint(equalTo: sizeView.widthAnchor),
            sizeValueLabel.heightAnchor.constraint(equalTo: careValueLabel.heightAnchor),
            
            // MARK: - Light
            
            lightImage.topAnchor.constraint(equalTo: lightView.topAnchor),
            lightImage.leadingAnchor.constraint(equalTo: lightView.leadingAnchor),
            
            lightLabel.topAnchor.constraint(equalTo: lightView.topAnchor, constant: 2),
            lightLabel.leadingAnchor.constraint(equalTo: lightImage.trailingAnchor, constant: 5),
            
            lightValueLabel.topAnchor.constraint(equalTo: lightLabel.bottomAnchor, constant: 10),
            lightValueLabel.leadingAnchor.constraint(equalTo: lightView.leadingAnchor),
            lightValueLabel.bottomAnchor.constraint(equalTo: lightView.bottomAnchor),
            lightValueLabel.widthAnchor.constraint(equalTo: lightView.widthAnchor),
            lightValueLabel.heightAnchor.constraint(equalTo: humidityValueLabel.heightAnchor),

            // MARK: - Humidity
            
            humidityImage.topAnchor.constraint(equalTo: humidityView.topAnchor),
            humidityImage.leadingAnchor.constraint(equalTo: humidityView.leadingAnchor),
            
            humidityLabel.topAnchor.constraint(equalTo: humidityView.topAnchor, constant: 2),
            humidityLabel.leadingAnchor.constraint(equalTo: humidityImage.trailingAnchor, constant: 5),
            
            humidityValueLabel.topAnchor.constraint(equalTo: humidityLabel.bottomAnchor, constant: 10),
            humidityValueLabel.leadingAnchor.constraint(equalTo: humidityView.leadingAnchor),
            humidityValueLabel.bottomAnchor.constraint(equalTo: humidityView.bottomAnchor),
            humidityValueLabel.widthAnchor.constraint(equalTo: humidityView.widthAnchor),
            humidityValueLabel.heightAnchor.constraint(equalTo: temperatureValueLabel.heightAnchor),

            // MARK: - Temperature
            
            temperatureImage.topAnchor.constraint(equalTo: temperatureView.topAnchor),
            temperatureImage.leadingAnchor.constraint(equalTo: temperatureView.leadingAnchor),
            
            temperatureLabel.topAnchor.constraint(equalTo: temperatureView.topAnchor, constant: 2),
            temperatureLabel.leadingAnchor.constraint(equalTo: temperatureImage.trailingAnchor, constant: 5),
            
            temperatureValueLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 10),
            temperatureValueLabel.leadingAnchor.constraint(equalTo: temperatureView.leadingAnchor),
            temperatureValueLabel.bottomAnchor.constraint(equalTo: temperatureView.bottomAnchor),
            temperatureValueLabel.widthAnchor.constraint(equalTo: temperatureView.widthAnchor),
            temperatureValueLabel.heightAnchor.constraint(equalTo: lightValueLabel.heightAnchor),
            
            // MARK: - Origin
            
            originImage.topAnchor.constraint(equalTo: originView.topAnchor),
            originImage.leadingAnchor.constraint(equalTo: originView.leadingAnchor),
            
            originLabel.topAnchor.constraint(equalTo: originView.topAnchor, constant: 2),
            originLabel.leadingAnchor.constraint(equalTo: originImage.trailingAnchor, constant: 5),
            
            originValueLabel.topAnchor.constraint(equalTo: originLabel.bottomAnchor, constant: 10),
            originValueLabel.leadingAnchor.constraint(equalTo: originView.leadingAnchor),
            originValueLabel.bottomAnchor.constraint(equalTo: originView.bottomAnchor),
            originValueLabel.widthAnchor.constraint(equalToConstant: view.frame.width - 40),
            
            // MARK: - Price and Add to Cart View

            bottonView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottonView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottonView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            bottonView.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.1),
            
            priceStackView.topAnchor.constraint(equalTo: bottonView.topAnchor, constant: 10),
            priceStackView.leadingAnchor.constraint(equalTo: bottonView.leadingAnchor, constant: 20),
            priceStackView.trailingAnchor.constraint(equalTo: addToCartButton.leadingAnchor),
            priceStackView.bottomAnchor.constraint(equalTo: bottonView.bottomAnchor, constant: -10),
            
            priceLabel.topAnchor.constraint(equalTo: priceStackView.topAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: priceStackView.leadingAnchor),
            
            priceValueLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 5),
            priceValueLabel.leadingAnchor.constraint(equalTo: priceStackView.leadingAnchor),
            priceValueLabel.bottomAnchor.constraint(equalTo: priceStackView.bottomAnchor),
            
            addToCartButton.topAnchor.constraint(equalTo: bottonView.topAnchor, constant: 10),
            addToCartButton.trailingAnchor.constraint(equalTo: bottonView.trailingAnchor, constant: -20),
            addToCartButton.bottomAnchor.constraint(equalTo: bottonView.bottomAnchor, constant: -10),
            addToCartButton.widthAnchor.constraint(equalToConstant: view.frame.width * 0.5)
        ])
    }
}
