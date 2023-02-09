//
//  FeaturesStackView.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 05.02.2023.
//

import UIKit

final class FeaturesStackView: UIStackView {
    
    var featuresData: ShopItemFeatures?
        
    private let careLevelView = ShopFeatureView()
    private let petView = ShopFeatureView()
    private let sizeView = ShopFeatureView()
        
    private let lightView = ShopFeatureView()
    private let humidityView = ShopFeatureView()
    private let temperatureView = ShopFeatureView()
    
    private let originView = ShopFeatureView()
    
    func setup(with featuresData: ShopItemFeatures) {
        self.featuresData = featuresData
        setupViews()
    }
    
    private func createStackView(subviews: [UIView]) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        subviews.forEach { stackView.addArrangedSubview($0) }
        return stackView
    }
    
    private func setupViews() {
        guard let featuresData else { return }
        
        axis = .vertical
        distribution = .fill
        spacing = 20
        
        addArrangedSubview(createStackView(
            subviews: [careLevelView, petView, sizeView]
        ))
        addArrangedSubview(createStackView(
            subviews: [lightView, humidityView, temperatureView]
        ))
        addArrangedSubview(originView)
        
        careLevelView.setup(image: Resources.Images.Features.careLevel,
                            name: Resources.Strings.Common.Detail.careLevel,
                            value: featuresData.careLevel)
        petView.setup(image: Resources.Images.Features.petFriendly,
                      name: Resources.Strings.Common.Detail.petFriendly,
                      value: featuresData.petFriendly)
        sizeView.setup(image: Resources.Images.Features.size,
                       name: Resources.Strings.Common.Detail.size,
                       value: featuresData.size)
        lightView.setup(image: Resources.Images.Features.light,
                        name: Resources.Strings.Common.Detail.light,
                        value: featuresData.light)
        humidityView.setup(image: Resources.Images.Features.humidity,
                           name: Resources.Strings.Common.Detail.humidity,
                           value: featuresData.humidity)
        temperatureView.setup(image: Resources.Images.Features.temperature,
                              name: Resources.Strings.Common.Detail.temperature,
                              value: featuresData.temperature)
        originView.setup(image: Resources.Images.Features.origin,
                         name: Resources.Strings.Common.Detail.origin,
                         value: featuresData.origin)
    }
}
