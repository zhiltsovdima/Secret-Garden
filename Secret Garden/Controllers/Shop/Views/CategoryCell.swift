//
//  CategoryCell.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 13.11.2022.
//

import UIKit

final class CategoryCell: UICollectionViewCell {
    
    private let categoryLabel = UILabel()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                categoryLabel.textColor = .black
                categoryLabel.layer.borderColor = UIColor.black.cgColor
            } else {
                categoryLabel.textColor = .lightGray
                categoryLabel.layer.borderColor = UIColor.lightGray.cgColor
            }
        }
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCategory(_ category: String) {
        categoryLabel.text = category
    }
    
    private func configure() {
        addSubview(categoryLabel)
        categoryLabel.textAlignment = .center
        categoryLabel.layer.cornerRadius = 15
        categoryLabel.layer.borderWidth = 1
    }
    
    private func setConstraints() {
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: topAnchor),
            categoryLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            categoryLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            categoryLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
