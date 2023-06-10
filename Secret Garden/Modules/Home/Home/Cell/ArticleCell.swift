//
//  NewsCell.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 21.05.2023.
//

import UIKit
import RxSwift
import RxCocoa

final class ArticleCell: UITableViewCell {
    
    private let articleImageView = UIImageView()

    private let stackView = UIStackView()
    private let titleLabel = UILabel()
    private let categoryLabel = UILabel()
    private let dateLabel = UILabel()
    
    let disposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with model: ArticleViewModelProtocol) {
        titleLabel.text = model.title
        categoryLabel.text = model.category
        dateLabel.text = model.date
        
        model.image
            .bind(to: articleImageView.rx.image)
            .disposed(by: disposeBag)
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        backgroundColor = .clear

        [articleImageView, stackView].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        [categoryLabel, titleLabel, dateLabel].forEach { stackView.addArrangedSubview($0) }
        
        categoryLabel.font = Font.general
        categoryLabel.textColor = .lightGray
        titleLabel.numberOfLines = 0
        titleLabel.font = Font.subHeader
        titleLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        dateLabel.font = Font.general
        dateLabel.textColor = .lightGray
        
        articleImageView.layer.cornerRadius = 20
        articleImageView.clipsToBounds = true
        articleImageView.contentMode = .scaleAspectFill
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            articleImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            articleImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            articleImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            articleImageView.widthAnchor.constraint(equalTo: articleImageView.heightAnchor),
        
            stackView.topAnchor.constraint(equalTo: articleImageView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: articleImageView.trailingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
}
