//
//  FeatureCell.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 13.12.2022.
//

import UIKit

class FeatureCell: UITableViewCell {
    
    private let featureImage = UIImageView()
    private let featureLabel = UILabel()
    
    private let titleAttributes = [NSAttributedString.Key.font: Resources.Fonts.generalBold!]
    private let generalAttributes = [NSAttributedString.Key.font: Resources.Fonts.general!]
    
    func set(featureName: String, featureValue: String) {
        let atrString1 = NSMutableAttributedString(string: featureName + ": ",
                                                    attributes: titleAttributes)
        let atrString2 = NSMutableAttributedString(string: featureValue,
                                                    attributes: generalAttributes)
        atrString1.append(atrString2)
        featureLabel.attributedText = atrString1
        setImage(featureName)
        setupViews()
    }
    
    private func setImage(_ name: String) {
        switch name {
        case Resources.Strings.Common.Detail.origin:
            featureImage.image = Resources.Images.Characteristics.origin
        case Resources.Strings.Common.Detail.light:
            featureImage.image = Resources.Images.Characteristics.light
        case Resources.Strings.Common.Detail.watering:
            featureImage.image = Resources.Images.Characteristics.humidity
        case Resources.Strings.Common.Detail.temperature:
            featureImage.image = Resources.Images.Characteristics.temperature
        case Resources.Strings.Common.Detail.insects:
            featureImage.image = Resources.Images.Characteristics.insects
        default:
            break
        }
    }
    
    private func setupViews() {
        addSubview(featureImage)
        addSubview(featureLabel)
        featureLabel.numberOfLines = 0
        featureLabel.textAlignment = .left
        featureImage.contentMode = .scaleAspectFit
        
        featureLabel.translatesAutoresizingMaskIntoConstraints = false
        featureImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            featureImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            featureImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            featureImage.heightAnchor.constraint(equalToConstant: 25),
            featureImage.widthAnchor.constraint(equalTo: featureImage.heightAnchor),

            featureLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            featureLabel.leadingAnchor.constraint(equalTo: featureImage.trailingAnchor, constant: 10),
            featureLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
