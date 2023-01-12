//
//  FeatureCell.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 13.12.2022.
//

import UIKit

struct FeatureCellModel {
    var featureImage: UIImage?
    var featureValue: NSMutableAttributedString?
}

class FeatureCell: UITableViewCell {
    
    private var model: FeatureCellModel?
    
    private let featureImage = UIImageView()
    private let featureLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with model: FeatureCellModel) {
        self.model = model
        featureImage.image = model.featureImage
        featureLabel.attributedText = model.featureValue
    }
    
    private func setupUI() {
        backgroundColor = Resources.Colors.backgroundColor
    
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
