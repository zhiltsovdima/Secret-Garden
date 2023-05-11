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
    private let descriptionView = UIView()
    private let descriptionLabel = UILabel()
        
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
    
    private func setupViews() {
        view.backgroundColor = Resources.Colors.backgroundColor
        
        [weatherView, tipView, descriptionView, descriptionLabel].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        weatherView.setup(with: viewModel.weather)
        
        descriptionView.layer.borderWidth = 1
        descriptionView.layer.borderColor = Resources.Colors.blackOnWhite?.cgColor
        descriptionView.layer.cornerRadius = 20
        
        descriptionView.addSubview(descriptionLabel)
        descriptionLabel.text = Resources.Strings.Home.descriptionTitle + Resources.Strings.Home.descriptionBody
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = Font.generalLight
        descriptionLabel.adjustsFontSizeToFitWidth = true
    }
    
    private func setConstraints() {

        NSLayoutConstraint.activate([
            weatherView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            weatherView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            weatherView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            weatherView.bottomAnchor.constraint(equalTo: tipView.topAnchor),
            
            tipView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            tipView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tipView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tipView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/6),
            
            descriptionView.topAnchor.constraint(equalTo: tipView.bottomAnchor, constant: 30),
            descriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            descriptionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: descriptionView.topAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: descriptionView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: descriptionView.trailingAnchor, constant: -20),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: descriptionView.bottomAnchor, constant: -20)
        ])
    }
    
}
