//
//  CharacteristicCell.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 13.12.2022.
//

import UIKit

class CharacteristicCell: UITableViewCell {
    
    private let characteristicImage = UIImageView()
    private let characteristicLabel = UILabel()
    
    private let titleAttributes = [NSAttributedString.Key.font: Resources.Fonts.generalBold!]
    private let generalAttributes = [NSAttributedString.Key.font: Resources.Fonts.general!]
    
    func set(characteristicName: String, characteristicValue: String) {
        let atrString1 = NSMutableAttributedString(string: characteristicName + ": ",
                                                    attributes: titleAttributes)
        let atrString2 = NSMutableAttributedString(string: characteristicValue,
                                                    attributes: generalAttributes)
        atrString1.append(atrString2)
        characteristicLabel.attributedText = atrString1
        setImage(characteristicName)
        setupViews()
    }
    
    private func setImage(_ name: String) {
        switch name {
        case Resources.Strings.Common.Detail.origin:
            characteristicImage.image = Resources.Images.Characteristics.origin
        case Resources.Strings.Common.Detail.light:
            characteristicImage.image = Resources.Images.Characteristics.light
        case Resources.Strings.Common.Detail.watering:
            characteristicImage.image = Resources.Images.Characteristics.humidity
        case Resources.Strings.Common.Detail.temperature:
            characteristicImage.image = Resources.Images.Characteristics.temperature
        case Resources.Strings.Common.Detail.insects:
            characteristicImage.image = Resources.Images.Characteristics.insects
        default:
            break
        }
    }
    
    private func setupViews() {
        addSubview(characteristicImage)
        addSubview(characteristicLabel)
        characteristicLabel.numberOfLines = 0
        characteristicLabel.textAlignment = .left
        characteristicImage.contentMode = .scaleAspectFit
        
        characteristicLabel.translatesAutoresizingMaskIntoConstraints = false
        characteristicImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            characteristicImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            characteristicImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            characteristicImage.heightAnchor.constraint(equalToConstant: 25),
            characteristicImage.widthAnchor.constraint(equalTo: characteristicImage.heightAnchor),

            characteristicLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            characteristicLabel.leadingAnchor.constraint(equalTo: characteristicImage.trailingAnchor, constant: 10),
            characteristicLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
