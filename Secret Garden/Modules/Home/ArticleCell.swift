//
//  NewsCell.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 21.05.2023.
//

import UIKit

final class ArticleCell: UITableViewCell {
    
    private let titleLabel = UILabel()
    private let articleImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with model: ArticleModel) {
        titleLabel.text = model.title
    }
    
    func updateImage(_ image: UIImage?) {
        articleImageView.image = image
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        backgroundColor = .clear

        [titleLabel, articleImageView].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        titleLabel.numberOfLines = 0
        titleLabel.font = Font.generalBold
        
        articleImageView.layer.cornerRadius = 10
        articleImageView.clipsToBounds = true
        articleImageView.contentMode = .scaleAspectFill
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            articleImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            articleImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            articleImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            articleImageView.widthAnchor.constraint(equalTo: articleImageView.heightAnchor),
        
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: articleImageView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        ])
    }
}
