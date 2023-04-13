//
//  HomeViewController.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 29.10.2022.
//

import UIKit

final class HomeViewController: UIViewController {
    
    private let tipImageView = UIImageView()
    private let tipBackgroundView = UIView()
    
    private let tipTitleLabel = UILabel()
    private let tipBodyLabel = UILabel()
    
    private let descriptionView = UIView()
    private let descriptionLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = Resources.Colors.backgroundColor
        view.addSubview(tipBackgroundView)
        tipBackgroundView.backgroundColor = Resources.Colors.tipBackground
        tipBackgroundView.layer.cornerRadius = 20
        
        tipBackgroundView.addSubview(tipImageView)
        tipImageView.image = Resources.Images.Home.tip
        
        tipBackgroundView.addSubview(tipTitleLabel)
        tipTitleLabel.text = Resources.Strings.Home.tipTitle
        tipTitleLabel.font = Resources.Fonts.generalBold
        tipTitleLabel.textColor = .black
        
        tipBackgroundView.addSubview(tipBodyLabel)
        tipBodyLabel.numberOfLines = 0
        tipBodyLabel.text = Tips.all.randomElement()
        tipBodyLabel.font = Resources.Fonts.general
        tipBodyLabel.adjustsFontSizeToFitWidth = true
        tipBodyLabel.textColor = .black
        
        view.addSubview(descriptionView)
        descriptionView.layer.borderWidth = 1
        descriptionView.layer.borderColor = Resources.Colors.blackOnWhite?.cgColor
        descriptionView.layer.cornerRadius = 20
        
        descriptionView.addSubview(descriptionLabel)
        descriptionLabel.text = Resources.Strings.Home.descriptionTitle + Resources.Strings.Home.descriptionBody
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = Resources.Fonts.general
        descriptionLabel.adjustsFontSizeToFitWidth = true
    }
    
    private func setConstraints() {
        tipBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        tipImageView.translatesAutoresizingMaskIntoConstraints = false
        tipTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        tipBodyLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tipBackgroundView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            tipBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tipBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tipBackgroundView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/8),

            tipImageView.topAnchor.constraint(equalTo: tipBackgroundView.topAnchor, constant: -30),
            tipImageView.trailingAnchor.constraint(equalTo: tipBackgroundView.trailingAnchor),
            tipImageView.bottomAnchor.constraint(equalTo: tipBackgroundView.bottomAnchor, constant: -10),
            tipImageView.widthAnchor.constraint(equalTo: tipImageView.heightAnchor),
 
            tipTitleLabel.topAnchor.constraint(equalTo: tipBackgroundView.topAnchor, constant: 15),
            tipTitleLabel.leadingAnchor.constraint(equalTo: tipBackgroundView.leadingAnchor, constant: 25),
            tipTitleLabel.trailingAnchor.constraint(equalTo: tipImageView.leadingAnchor, constant: -10),

            tipBodyLabel.topAnchor.constraint(equalTo: tipTitleLabel.bottomAnchor, constant: 5),
            tipBodyLabel.leadingAnchor.constraint(equalTo: tipBackgroundView.leadingAnchor, constant: 25),
            tipBodyLabel.trailingAnchor.constraint(equalTo: tipImageView.leadingAnchor, constant: -10),
            tipBodyLabel.bottomAnchor.constraint(equalTo: tipBackgroundView.bottomAnchor, constant: -10),
            
            descriptionView.topAnchor.constraint(equalTo: tipBackgroundView.bottomAnchor, constant: 30),
            descriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            descriptionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: descriptionView.topAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: descriptionView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: descriptionView.trailingAnchor, constant: -20),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: descriptionView.bottomAnchor, constant: -20)
        ])
    }
    
}
