//
//  HomeViewController.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 29.10.2022.
//

import UIKit
import RxSwift
import RxCocoa

final class HomeViewController: UIViewController {
    
    private let viewModel: HomeViewModelProtocol
    
    private let weatherImage = UIImageView()
    private let weatherStack = UIStackView()
    private let temperatureLabel = UILabel()
    private let placeLabel = UILabel()
    
    private let tipView = TipView()
    private let descriptionView = UIView()
    private let descriptionLabel = UILabel()
    
    private let disposeBag = DisposeBag()
    
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
        
        viewModel.weather
            .observe(on: MainScheduler.instance)
            .compactMap({ weather in
                return (weather?.weatherImage, weather?.temperatureString, weather?.cityName)
            })
            .bind(onNext: { [weak self] (image, temp, place) in
                guard let self else { return }
                self.weatherImage.image = image
                self.temperatureLabel.text = temp
                self.placeLabel.text = place
            })
            .disposed(by: disposeBag)
    }
    
    private func setupViews() {
        view.backgroundColor = Resources.Colors.backgroundColor
        
        [weatherImage, weatherStack, tipView, descriptionView, descriptionLabel].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        weatherImage.contentMode = .scaleAspectFit
        
        weatherStack.axis = .vertical
        weatherStack.spacing = 5
        [placeLabel, temperatureLabel].forEach { weatherStack.addArrangedSubview($0) }
        temperatureLabel.font = UIFont.boldSystemFont(ofSize: 20)
        placeLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        descriptionView.layer.borderWidth = 1
        descriptionView.layer.borderColor = Resources.Colors.blackOnWhite?.cgColor
        descriptionView.layer.cornerRadius = 20
        
        descriptionView.addSubview(descriptionLabel)
        descriptionLabel.text = Resources.Strings.Home.descriptionTitle + Resources.Strings.Home.descriptionBody
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = Resources.Fonts.general
        descriptionLabel.adjustsFontSizeToFitWidth = true
    }
    
    private func setConstraints() {

        NSLayoutConstraint.activate([
            weatherImage.topAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor),
            weatherImage.leadingAnchor.constraint(equalTo: tipView.leadingAnchor),
            weatherImage.bottomAnchor.constraint(equalTo: tipView.topAnchor),
            
            weatherStack.centerYAnchor.constraint(equalTo: weatherImage.centerYAnchor),
            weatherStack.leadingAnchor.constraint(equalTo: weatherImage.trailingAnchor, constant: 10),
            
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
