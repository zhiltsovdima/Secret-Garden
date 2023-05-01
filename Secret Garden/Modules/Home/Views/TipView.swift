//
//  TipView.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 01.05.2023.
//

import UIKit

final class TipView: UIView {
    
    private let tipBackgroundView = UIView()
    private let tipStackView = UIStackView()
    
    private let tipImageView = UIImageView()
    private let tipTitleLabel = UILabel()
    private let tipBodyLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .clear
        
        addSubview(tipBackgroundView)
        tipBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        tipBackgroundView.backgroundColor = Resources.Colors.tipBackground
        tipBackgroundView.layer.cornerRadius = 20
        
        tipImageView.image = Resources.Images.Home.tip
        
        tipStackView.axis = .vertical
        tipStackView.distribution = .fillProportionally
        tipStackView.spacing = 5
        [tipTitleLabel, tipBodyLabel].forEach { tipStackView.addArrangedSubview($0) }
        
        tipTitleLabel.text = Resources.Strings.Home.tipTitle
        tipTitleLabel.font = Resources.Fonts.generalBold?.withSize(16)
        tipTitleLabel.textColor = .black
        
        tipBodyLabel.numberOfLines = 0
        tipBodyLabel.text = Tips.all.randomElement()
        tipBodyLabel.font = Resources.Fonts.general?.withSize(14)
        tipBodyLabel.textColor = .black
        tipBodyLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
        
        [tipImageView, tipStackView].forEach {
            tipBackgroundView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tipBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tipBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tipBackgroundView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            tipBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            tipStackView.topAnchor.constraint(equalTo: tipBackgroundView.topAnchor, constant: 10),
            tipStackView.leadingAnchor.constraint(equalTo: tipBackgroundView.leadingAnchor, constant: 20),
            tipStackView.trailingAnchor.constraint(equalTo: tipImageView.leadingAnchor),
            tipStackView.bottomAnchor.constraint(lessThanOrEqualTo: tipBackgroundView.bottomAnchor, constant: -10),
            
            tipImageView.topAnchor.constraint(equalTo: topAnchor),
            tipImageView.bottomAnchor.constraint(equalTo: tipBackgroundView.bottomAnchor, constant: -10),
            tipImageView.trailingAnchor.constraint(equalTo: tipBackgroundView.trailingAnchor),
            tipImageView.widthAnchor.constraint(equalTo: tipImageView.heightAnchor)
        ])
    }
    
}
