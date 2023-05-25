//
//  DetailArticleController.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 25.05.2023.
//

import UIKit

final class DetailArticleController: UIViewController {
    
    private let viewModel: DetailArticleViewModelProtocol
        
    private let scrollView = UIScrollView()
    private let imageView = GradientImageView()
    private let detailView = UIView()
    
    init(viewModel: DetailArticleViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.addSubview(scrollView)
        
        [imageView, detailView].forEach {
            scrollView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        imageView.image = viewModel.article.image.value
        imageView.contentMode = .scaleAspectFill
        imageView.setupGradient()
        
        detailView.backgroundColor = Resources.Colors.backgroundColor
        detailView.layer.cornerRadius = 20
        detailView.clipsToBounds = true
    }
    
    private func setupConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/2),
            
            detailView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -20),
            detailView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            detailView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
}
