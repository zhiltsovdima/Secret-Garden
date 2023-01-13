//
//  PlantCell.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 01.11.2022.
//

import UIKit

struct PlantCellModel {
    var plantImage: UIImage?
    var plantTitle: String
}

final class PlantCell: UITableViewCell {
    
    private var model: PlantCellModel?

    private var plantImageView = UIImageView()
    private var plantTitleLabel = UILabel()
    var settingsButton = UIButton()
        
    var buttonCompletionHandler: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with model: PlantCellModel) {
        self.model = model
        plantImageView.image = model.plantImage
        plantTitleLabel.text = model.plantTitle
    }
    
    @objc private func settingsButtonAction() {
        buttonCompletionHandler?()
    }
    
}

// MARK: - Views Settings

extension PlantCell {
    
    private func setupViews() {
        backgroundColor = Resources.Colors.backgroundColor

        addSubview(plantImageView)
        addSubview(plantTitleLabel)
        contentView.addSubview(settingsButton)
        
        plantImageView.layer.cornerRadius = 10
        plantImageView.clipsToBounds = true
        plantImageView.contentMode = .scaleAspectFill
 
        plantTitleLabel.numberOfLines = 0
        plantTitleLabel.font = Resources.Fonts.general?.withSize(18)

        settingsButton.setImage(Resources.Images.Common.moreOptions, for: .normal)
        settingsButton.addTarget(self, action: #selector(settingsButtonAction), for: .touchUpInside)
        makeSystemAnimation(for: settingsButton)
    }
    
    private func setupConstraints() {
        plantImageView.translatesAutoresizingMaskIntoConstraints = false
        plantTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            plantImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            plantImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            plantImageView.heightAnchor.constraint(equalToConstant: 150),
            plantImageView.widthAnchor.constraint(equalToConstant: 150),

            plantTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            plantTitleLabel.leadingAnchor.constraint(equalTo: plantImageView.trailingAnchor, constant: 20),
            plantTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
   
            settingsButton.widthAnchor.constraint(equalToConstant: 30),
            settingsButton.heightAnchor.constraint(equalToConstant: 30),
            settingsButton.topAnchor.constraint(equalTo: topAnchor, constant: 25),
            settingsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)
        ])
    }
}
