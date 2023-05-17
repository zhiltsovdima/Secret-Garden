//
//  HomeViewController.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 29.10.2022.
//

import UIKit

final class HomeViewController: UIViewController {
    
    private let viewModel: HomeViewModelProtocol
    
    private let weatherView = WeatherView()
    private let tipView = TipView()
    
    private let buttonsStackView = UIStackView()
    private let gardenButton = QuickJumpButton()
    private let shopButton = QuickJumpButton()
    private let plantRecognizerButton = QuickJumpButton()
        
    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
    }
    
    @objc private func gardenButtonTapped() {
        viewModel.gardenButtonTapped()
    }
    
    @objc private func shopButtonTapped() {
        viewModel.shopButtonTapped()
    }
    
    private func setupViews() {
        view.backgroundColor = Resources.Colors.backgroundColor
        
        [weatherView, tipView, buttonsStackView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        weatherView.setup(with: viewModel.weather)
        
        gardenButton.setup(
            title: "My garden",
            image: Resources.Images.Home.garden,
            color: Resources.Colors.accent
        )
        shopButton.setup(
            title: "Shop",
            image: Resources.Images.Home.shop,
            color: Resources.Colors.secondAccent
        )
        plantRecognizerButton.setup(
            title: "Soon",
            image: Resources.Images.Home.plantRecognizer,
            color: .lightGray
        )
        gardenButton.addTarget(self, action: #selector(gardenButtonTapped), for: .touchUpInside)
        shopButton.addTarget(self, action: #selector(shopButtonTapped), for: .touchUpInside)
        
        [gardenButton, shopButton, plantRecognizerButton].forEach { buttonsStackView.addArrangedSubview($0) }
        buttonsStackView.axis = .horizontal
        buttonsStackView.distribution = .fillEqually
        buttonsStackView.spacing = 20
        plantRecognizerButton.isEnabled = false
    }
    
    private func setConstraints() {

        NSLayoutConstraint.activate([
            weatherView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            weatherView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            weatherView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            weatherView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/9),
            
            tipView.topAnchor.constraint(equalTo: weatherView.bottomAnchor),
            tipView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tipView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tipView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/7),
            
            buttonsStackView.topAnchor.constraint(equalTo: tipView.bottomAnchor, constant: 20),
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            buttonsStackView.heightAnchor.constraint(equalTo: gardenButton.widthAnchor)
        ])
    }
    
}
