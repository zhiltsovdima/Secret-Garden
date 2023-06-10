//
//  GradientImageView.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 25.05.2023.
//

import UIKit

final class GradientImageView: UIImageView {
    
    private let topGradientLayer = CAGradientLayer()
    private let bottomGradientLayer = CAGradientLayer()
    
    private let labelsStackView = UIStackView()
    private let categoryView = CategoryView()
    private let titleLabel = UILabel()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        topGradientLayer.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height / 2)
        bottomGradientLayer.frame = CGRect(x: 0, y: bounds.height / 2, width: bounds.width, height: bounds.height / 2)
    }
    
    func setupGradient() {
        let darkColor = UIColor.black.withAlphaComponent(0.8).cgColor
        let lightColor = UIColor.clear.cgColor
        topGradientLayer.colors = [darkColor, lightColor]
        topGradientLayer.startPoint = CGPoint(x: 0, y: 0)
        topGradientLayer.endPoint = CGPoint(x: 0, y: 1)
        
        bottomGradientLayer.colors = [lightColor, darkColor]
        bottomGradientLayer.startPoint = CGPoint(x: 0, y: 0)
        bottomGradientLayer.endPoint = CGPoint(x: 0, y: 1.0)
        
        layer.addSublayer(topGradientLayer)
        layer.addSublayer(bottomGradientLayer)
    }
    
    func setupLabels(with model: ArticleViewModelProtocol) {
        addSubview(labelsStackView)
        labelsStackView.axis = .vertical
        labelsStackView.alignment = .leading
        labelsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        categoryView.setup(with: model.category)

        titleLabel.text = model.title
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        titleLabel.font = Font.header
        
        [categoryView, titleLabel].forEach {
            labelsStackView.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            labelsStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40),
            labelsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            labelsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            categoryView.widthAnchor.constraint(equalToConstant: 100),
            categoryView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
