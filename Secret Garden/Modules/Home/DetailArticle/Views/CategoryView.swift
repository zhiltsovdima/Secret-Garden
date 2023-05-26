//
//  CategoryView.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 26.05.2023.
//

import UIKit

final class CategoryView: UIView {
    
    private let categoryLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
    }
    
    func setup(with category: String) {
        backgroundColor = Resources.Colors.lightText.withAlphaComponent(0.7)
        
        addSubview(categoryLabel)
        categoryLabel.text = category
        categoryLabel.font = Font.generalBold
        categoryLabel.textColor = .white
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            categoryLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            categoryLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
