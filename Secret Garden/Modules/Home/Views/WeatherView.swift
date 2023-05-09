//
//  WeatherView.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 09.05.2023.
//

import UIKit
import RxSwift
import RxCocoa

final class WeatherView: UIView {
    
    private let leftWeatherStack = UIStackView()
    private let placeLabel = UILabel()
    private let temperatureLabel = UILabel()
    
    private let rightWeatherStack = UIStackView()
    private let weatherImage = UIImageView()
    private let tempDescription = UILabel()
    private let tempMinMaxLabel = UILabel()
    
    private let disposeBag = DisposeBag()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with weather: BehaviorRelay<WeatherModel?>) {
        weather
            .observe(on: MainScheduler.instance)
            .compactMap({ weather in
                return (weather?.weatherImage, weather?.temperatureString, weather?.placeName, weather?.description, weather?.tempMinMaxString)
            })
            .bind(onNext: { [weak self] (image, temp, place, tempDescription, tempMinMax) in
                guard let self else { return }
                self.weatherImage.image = image
                self.temperatureLabel.text = temp
                self.placeLabel.text = place
                self.tempDescription.text = tempDescription
                self.tempMinMaxLabel.text = tempMinMax
            })
            .disposed(by: disposeBag)
    }
    
    private func setupUI() {
        backgroundColor = .clear
        
        [leftWeatherStack, rightWeatherStack].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [placeLabel, temperatureLabel].forEach { leftWeatherStack.addArrangedSubview($0) }
        leftWeatherStack.axis = .vertical
        leftWeatherStack.alignment = .leading
        
        placeLabel.font = UIFont.boldSystemFont(ofSize: 16)
        placeLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        temperatureLabel.font = UIFont.boldSystemFont(ofSize: 40)
        
        [weatherImage, tempDescription, tempMinMaxLabel].forEach { rightWeatherStack.addArrangedSubview($0) }
        rightWeatherStack.axis = .vertical
        rightWeatherStack.alignment = .trailing
        rightWeatherStack.distribution = .fillEqually
        
        weatherImage.contentMode = .scaleAspectFit
        tempDescription.font = UIFont.boldSystemFont(ofSize: 15)
        tempMinMaxLabel.font = UIFont.boldSystemFont(ofSize: 15)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            leftWeatherStack.topAnchor.constraint(equalTo: topAnchor),
            leftWeatherStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            leftWeatherStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            leftWeatherStack.trailingAnchor.constraint(lessThanOrEqualTo: rightWeatherStack.leadingAnchor),
            
            weatherImage.widthAnchor.constraint(equalTo: weatherImage.heightAnchor),
            
            rightWeatherStack.topAnchor.constraint(equalTo: topAnchor),
            rightWeatherStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            rightWeatherStack.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
}
