//
//  ItemDetailController.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 18.11.2022.
//

import UIKit

final class ItemDetailController: UIViewController {
    
    private let viewModel: ItemDetailViewModelProtocol
    
    private var favoriteImage: UIImage? {
        viewModel.isFavorite ? Resources.Images.Common.addToFavoriteFill : Resources.Images.Common.addToFavorite
    }
    private var favoriteImageTint: UIColor? {
        viewModel.isFavorite ? Resources.Colors.secondAccent : Resources.Colors.blackOnWhite
    }
    
    private let scrollView = UIScrollView()
    private let imageView = UIImageView()
    private let nameItem = UILabel()
    private let latinNameItem = UILabel()
    private let descriptionItem = UILabel()
    private let featuresStackView = FeaturesStackView()
    private let priceView = PriceView()
    
    init(viewModel: ItemDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        
        addNavBarButton()
        setupViews()
        setupConstraints()
        updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.viewWillDisappear()
    }
    
    @objc private func favoriteButtonAction() {
        viewModel.favoriteButtonTapped()
    }
    
    @objc private func addToCartButtonAction() {
        viewModel.cartButtonTapped()
    }
}

//MARK: - Update UI

extension ItemDetailController {
    
    private func updateUI() {
        viewModel.updateViewCompletion = { [weak self] updatedProperty in
            switch updatedProperty {
            case .favorite(_):
                self?.setFavoriteButtonAppearance()
            case .cart(_):
                self?.setCartButtonAppearance()
            case .all:
                self?.setFavoriteButtonAppearance()
                self?.setCartButtonAppearance()
            }
        }
    }
    
    private func setFavoriteButtonAppearance() {
        navigationItem.rightBarButtonItem?.image = favoriteImage
        navigationItem.rightBarButtonItem?.tintColor = favoriteImageTint
    }
    
    private func setCartButtonAppearance() {
        priceView.setCartButtonAppearance(isAddedToCart: viewModel.isAddedToCart)
    }
}

//MARK: - Views Settings

extension ItemDetailController {
    
    private func addNavBarButton() {
        let button = UIBarButtonItem(image: favoriteImage, style: .done, target: self, action: #selector(favoriteButtonAction))
        navigationItem.rightBarButtonItem = button
    }
    
    private func setupViews() {
        view.backgroundColor = Resources.Colors.backgroundColor
        view.addSubview(scrollView)
        
        scrollView.addSubview(imageView)
        imageView.image = viewModel.image
        imageView.contentMode = .scaleToFill
        
        scrollView.addSubview(nameItem)
        nameItem.text = viewModel.name
        nameItem.font = Font.header
        
        scrollView.addSubview(latinNameItem)
        latinNameItem.text = viewModel.latinName
        latinNameItem.font = Font.thinText
        latinNameItem.textColor = Resources.Colors.blackOnWhite
        
        scrollView.addSubview(descriptionItem)
        descriptionItem.numberOfLines = 0
        descriptionItem.text = viewModel.description
        descriptionItem.setLineSpacing(8)
        descriptionItem.font = Font.generalLight.withSize(14)
        
        scrollView.addSubview(featuresStackView)
        featuresStackView.setup(with: viewModel.featuresData!)

        view.addSubview(priceView)
        priceView.setup(price: viewModel.price)
        priceView.addToCartButton.addTarget(self, action: #selector(addToCartButtonAction), for: .touchUpInside)
        
        setCartButtonAppearance()
        setFavoriteButtonAppearance()
    }
    
    // MARK: - CONSTRAINTS
    
    private func setupConstraints() {
    
        let safeArea = view.safeAreaLayoutGuide
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameItem.translatesAutoresizingMaskIntoConstraints = false
        latinNameItem.translatesAutoresizingMaskIntoConstraints = false
        descriptionItem.translatesAutoresizingMaskIntoConstraints = false
        featuresStackView.translatesAutoresizingMaskIntoConstraints = false
        priceView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            // MARK: - ScrollView
            scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: priceView.topAnchor),
            
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30),
            imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -30),
            imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -60),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.25),
            
            nameItem.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            nameItem.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            
            latinNameItem.topAnchor.constraint(equalTo: nameItem.bottomAnchor),
            latinNameItem.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            
            // MARK: - DescriptionView
            
            descriptionItem.topAnchor.constraint(equalTo: latinNameItem.bottomAnchor, constant: 20),
            descriptionItem.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            descriptionItem.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor,constant: -20),
            descriptionItem.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40),
            
            // MARK: - FeaturesStackView
            
            featuresStackView.topAnchor.constraint(equalTo: descriptionItem.bottomAnchor, constant: 20),
            featuresStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            featuresStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            featuresStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -10),
            
            // MARK: - PriceView
            
            priceView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            priceView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            priceView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            priceView.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.1),

        ])
    }
}
