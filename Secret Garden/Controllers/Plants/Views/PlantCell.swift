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
    
    var settingsButton = UIButton()
    var buttonCompletionHandler: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(plantImageView)
        addSubview(plantTitleLabel)
        contentView.addSubview(settingsButton)
        
        configureViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(plant: Plant) {
        plantImageView.image = plant.image
        plantTitleLabel.text = plant.name
    }
    
    @objc func settingsButtonAction() {
        buttonCompletionHandler?()
    }
    
    private func configureViews() {
        plantImageView.layer.cornerRadius = 10
        plantImageView.clipsToBounds = true
        plantImageView.contentMode = .scaleAspectFill
 
        plantTitleLabel.numberOfLines = 0
        plantTitleLabel.minimumScaleFactor = 20.0
        plantTitleLabel.adjustsFontSizeToFitWidth = true

        settingsButton.setImage(Resources.Images.Common.moreOptions, for: .normal)
        settingsButton.addTarget(self, action: #selector(settingsButtonAction), for: .touchUpInside)
        makeSystemAnimation(for: settingsButton)
    }
    
    private func setConstraints() {
        plantImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            plantImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            plantImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            plantImageView.heightAnchor.constraint(equalToConstant: 150),
            plantImageView.widthAnchor.constraint(equalToConstant: 150)
        ])

        plantTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            plantTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            plantTitleLabel.leadingAnchor.constraint(equalTo: plantImageView.trailingAnchor, constant: 20),
            plantTitleLabel.heightAnchor.constraint(equalToConstant: 40),
            plantTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30)
        ])
        
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            settingsButton.widthAnchor.constraint(equalToConstant: 30),
            settingsButton.heightAnchor.constraint(equalToConstant: 30),
            settingsButton.topAnchor.constraint(equalTo: topAnchor, constant: 25),
            settingsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)
        ])
    }
}
