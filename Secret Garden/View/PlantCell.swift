//
//  PlantCell.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 01.11.2022.
//

import UIKit

final class PlantCell: UITableViewCell {
    
    var plantImageView = UIImageView()
    var plantTitleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(plantImageView)
        addSubview(plantTitleLabel)
        
        configureTitlelabel()
        configureImageView()
        setImageViewConstraints()
        setTitleLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(plant: Plant) {
        plantImageView.image = plant.image
        plantTitleLabel.text = plant.name
    }
    
    private func configureImageView() {
        plantImageView.layer.cornerRadius = 10
        plantImageView.clipsToBounds = true
        plantImageView.contentMode = .scaleAspectFill
    }
    
    private func configureTitlelabel() {
        plantTitleLabel.numberOfLines = 0
        plantTitleLabel.adjustsFontSizeToFitWidth = true
    }
    
    private func setImageViewConstraints() {
        plantImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            plantImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            plantImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            plantImageView.heightAnchor.constraint(equalToConstant: 150),
            plantImageView.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func setTitleLabelConstraints() {
        plantTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            plantTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            plantTitleLabel.leadingAnchor.constraint(equalTo: plantImageView.trailingAnchor, constant: 20),
            plantTitleLabel.heightAnchor.constraint(equalToConstant: 150),
            plantTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
}
