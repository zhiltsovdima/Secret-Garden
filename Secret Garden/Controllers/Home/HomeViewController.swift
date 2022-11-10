//
//  HomeViewController.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 29.10.2022.
//

import UIKit

final class HomeViewController: BaseViewController {
    
    let tipImageView = UIImageView()
    let tipBackgroundView = UIView()
    
    let tipTitleLabel = UILabel()
    let tipBodyLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
    }
    
    private func setupViews() {
        view.addSubview(tipBackgroundView)
        tipBackgroundView.backgroundColor = Resources.Colors.tipBackground
        tipBackgroundView.layer.cornerRadius = 20
        
        tipBackgroundView.addSubview(tipImageView)
        tipImageView.image = Resources.Images.Home.tip
        
        
        tipBackgroundView.addSubview(tipTitleLabel)
        tipTitleLabel.text = Resources.Strings.Home.tipTitle
        tipTitleLabel.font = UIFont(name: "Helvetica-Bold", size: 17)
        
        tipBackgroundView.addSubview(tipBodyLabel)
        tipBodyLabel.numberOfLines = 0
        tipBodyLabel.text = Resources.Strings.Home.tipBody
        tipBodyLabel.font = UIFont(name: "Helvetica", size: 15)
        
    }
    
    private func setConstraints() {
        tipBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tipBackgroundView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            tipBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tipBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tipBackgroundView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/8)
        ])
        
        tipImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tipImageView.topAnchor.constraint(equalTo: tipBackgroundView.topAnchor, constant: -30),
            tipImageView.trailingAnchor.constraint(equalTo: tipBackgroundView.trailingAnchor),
            tipImageView.bottomAnchor.constraint(equalTo: tipBackgroundView.bottomAnchor, constant: -10),
            tipImageView.widthAnchor.constraint(equalTo: tipImageView.heightAnchor)
        ])
        
        tipTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tipTitleLabel.topAnchor.constraint(equalTo: tipBackgroundView.topAnchor, constant: 15),
            tipTitleLabel.leadingAnchor.constraint(equalTo: tipBackgroundView.leadingAnchor, constant: 25),
            tipTitleLabel.trailingAnchor.constraint(equalTo: tipImageView.leadingAnchor, constant: -10)
        ])
        
        tipBodyLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tipBodyLabel.topAnchor.constraint(equalTo: tipTitleLabel.topAnchor, constant: 5),
            tipBodyLabel.leadingAnchor.constraint(equalTo: tipBackgroundView.leadingAnchor, constant: 25),
            tipBodyLabel.trailingAnchor.constraint(equalTo: tipImageView.leadingAnchor, constant: -10),
            tipBodyLabel.bottomAnchor.constraint(equalTo: tipBackgroundView.bottomAnchor, constant: -5)
        ])
    }
    
}
