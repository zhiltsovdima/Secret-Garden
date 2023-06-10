//
//  DetailArticleController.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 25.05.2023.
//

import UIKit
import RxSwift
import RxCocoa

final class DetailArticleController: UIViewController {
    
    private let viewModel: DetailArticleViewModelProtocol

    private let scrollView = UIScrollView()
    private let imageView = GradientImageView()
    private let detailView = UIView()
    private let fullTextLabel = UILabel()
    
    private let placeholder = UIActivityIndicatorView()
    private let errorMessage = UILabel()
    
    private let disposeBag = DisposeBag()
    
    init(viewModel: DetailArticleViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchFullText()
        setupBindings()
        setupAppearance()
        setupViews()
        setupConstraints()
    }
}

// MARK: - Setup Setings

extension DetailArticleController {
    
    private func setupBindings() {
        
        viewModel.loadingState
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] state in
                self?.updateUI(for: state)
            })
            .disposed(by: disposeBag)
        
        viewModel.article.fullText
            .observe(on: MainScheduler.instance)
            .subscribe { [weak fullTextLabel] text in
                guard let text else { return }
                fullTextLabel?.attributedText = NSAttributedString(string: text)
                fullTextLabel?.setLineSpacing(8)
            }
            .disposed(by: disposeBag)
    }
    
    private func updateUI(for state: LoadingState) {
        switch state {
        case .loading:
            placeholder.startAnimating()
            errorMessage.isHidden = true
        case .loaded:
            placeholder.stopAnimating()
        case .failed(let errorText):
            errorMessage.isHidden = false
            errorMessage.text = errorText
            placeholder.stopAnimating()
        default: break
        }
    }
    
    private func setupAppearance() {
        view.backgroundColor = Resources.Colors.backgroundColor
        navigationController?.navigationBar.tintColor = Resources.Colors.blackOnWhite
    }
    
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.delegate = self
        scrollView.contentInsetAdjustmentBehavior = .never

        imageView.image = viewModel.article.image.value
        imageView.contentMode = .scaleAspectFill
        imageView.setupGradient()
        imageView.setupLabels(with: viewModel.article)
        
        detailView.backgroundColor = Resources.Colors.backgroundColor
        detailView.layer.cornerRadius = 20
        detailView.clipsToBounds = true
        
        fullTextLabel.font = Font.generalLight.withSize(16)
        fullTextLabel.numberOfLines = 0
        
        errorMessage.font = Font.generalBold
        errorMessage.textColor = .red
        
        placeholder.hidesWhenStopped = true
        
        [fullTextLabel, errorMessage, placeholder].forEach {
            detailView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [imageView, detailView].forEach {
            scrollView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        fullTextLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/2),
            imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            detailView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -20),
            detailView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            detailView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            detailView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            fullTextLabel.topAnchor.constraint(equalTo: detailView.topAnchor, constant: 40),
            fullTextLabel.leadingAnchor.constraint(equalTo: detailView.leadingAnchor, constant: 20),
            fullTextLabel.trailingAnchor.constraint(equalTo: detailView.trailingAnchor, constant: -20),
            fullTextLabel.bottomAnchor.constraint(equalTo: detailView.bottomAnchor, constant: -20),
            
            placeholder.centerXAnchor.constraint(equalTo: detailView.centerXAnchor),
            placeholder.centerYAnchor.constraint(equalTo: detailView.centerYAnchor),

            errorMessage.centerXAnchor.constraint(equalTo: detailView.centerXAnchor),
            errorMessage.centerYAnchor.constraint(equalTo: detailView.centerYAnchor),
            errorMessage.leadingAnchor.constraint(equalTo: detailView.leadingAnchor, constant: 20),
            errorMessage.trailingAnchor.constraint(equalTo: detailView.trailingAnchor, constant: -20)
        ])
    }
}

// MARK: - UIScrollViewDelegate

extension DetailArticleController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        imageView.transform = CGAffineTransform(translationX: 0, y: offsetY/2)
    }
}
