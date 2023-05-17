//
//  QuickJumpButton.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 17.05.2023.
//

import UIKit

final class QuickJumpButton: UIButton {
    
    private let icon = UIImageView()
    private let headerLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(title: String?, image: UIImage?, color: UIColor?) {
        headerLabel.text = title
        icon.image = image
        backgroundColor = color
    }
    
    
    private func setupUI() {
        layer.cornerRadius = 20
        tintColor = .white
        makeSystemAnimation()

        [icon, headerLabel].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        headerLabel.font = Font.generalBold
        headerLabel.textColor = .white
        
        NSLayoutConstraint.activate([
            icon.centerXAnchor.constraint(equalTo: centerXAnchor),
            icon.centerYAnchor.constraint(equalTo: centerYAnchor),

            headerLabel.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 10),
            headerLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
    }
}
