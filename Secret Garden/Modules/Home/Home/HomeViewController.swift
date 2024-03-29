//
//  HomeViewController.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 29.10.2022.
//

import UIKit
import RxSwift
import RxCocoa

final class HomeViewController: UIViewController {
    
    private let viewModel: HomeViewModelProtocol
    
    private let weatherView = WeatherView()
    private let tipView = TipView()
    
    private let buttonsStackView = UIStackView()
    private let gardenButton = QuickJumpButton()
    private let shopButton = QuickJumpButton()
    private let plantRecognizerButton = QuickJumpButton()
    
    private let placeholder = UIActivityIndicatorView()
    private let errorMessage = UILabel()
    private let newsTableView = UITableView()
    
    private let disposeBag = DisposeBag()
        
    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBindings()
        viewModel.updateWeather()
        viewModel.updateNews()
        setupViews()
        setupTableView()
        setupConstraints()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @objc private func gardenButtonTapped() {
        viewModel.gardenButtonTapped()
    }
    
    @objc private func shopButtonTapped() {
        viewModel.shopButtonTapped()
    }
    
    private func setupBindings() {
        viewModel.loadingState
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] state in
                guard let self else { return }
                updateUI(for: state)
            })
            .disposed(by: disposeBag)
        
        viewModel.news
            .bind(to: newsTableView.rx.items(
                cellIdentifier: Resources.Identifiers.articleCell,
                cellType: ArticleCell.self)) { _, model, cell in
                    cell.setup(with: model)
                }
                .disposed(by: disposeBag)
    }
    
    private func updateUI(for state: LoadingState) {
        switch state {
        case .idle:
            newsTableView.isHidden = true
        case .loading:
            placeholder.startAnimating()
            errorMessage.isHidden = true
        case .loaded:
            newsTableView.isHidden = false
            placeholder.stopAnimating()
        case .failed(let errorText):
            errorMessage.isHidden = false
            errorMessage.text = errorText
            placeholder.stopAnimating()
        }
    }
    
    private func setupViews() {
        view.backgroundColor = Resources.Colors.backgroundColor
        
        [weatherView, tipView, buttonsStackView, newsTableView, placeholder, errorMessage].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        weatherView.setup(with: viewModel.weather)
        
        gardenButton.setup(
            title: "My garden",
            image: Resources.Images.Home.garden,
            color: Resources.Colors.gardenButtonHome
        )
        shopButton.setup(
            title: "Shop",
            image: Resources.Images.Home.shop,
            color: Resources.Colors.shopButtonHome
        )
        plantRecognizerButton.setup(
            title: "Soon",
            image: Resources.Images.Home.plantRecognizer,
            color: .lightGray
        )
        plantRecognizerButton.isEnabled = false
        plantRecognizerButton.alpha = 0.8
        
        gardenButton.addTarget(self, action: #selector(gardenButtonTapped), for: .touchUpInside)
        shopButton.addTarget(self, action: #selector(shopButtonTapped), for: .touchUpInside)
        
        [gardenButton, shopButton, plantRecognizerButton].forEach { buttonsStackView.addArrangedSubview($0) }
        buttonsStackView.axis = .horizontal
        buttonsStackView.distribution = .fillEqually
        buttonsStackView.spacing = 20
        
        placeholder.hidesWhenStopped = true
        errorMessage.font = Font.generalBold
        errorMessage.textColor = .red
    }
    
    private func setupTableView() {
        newsTableView.delegate = self
        newsTableView.register(ArticleCell.self, forCellReuseIdentifier: Resources.Identifiers.articleCell)
        newsTableView.isScrollEnabled = false
        newsTableView.backgroundColor = .clear
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            weatherView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            weatherView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            weatherView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            weatherView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/9),
            
            tipView.topAnchor.constraint(equalTo: weatherView.bottomAnchor),
            tipView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tipView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tipView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/7),
            
            buttonsStackView.topAnchor.constraint(equalTo: tipView.bottomAnchor, constant: 20),
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            buttonsStackView.heightAnchor.constraint(equalTo: gardenButton.widthAnchor),
            
            placeholder.centerXAnchor.constraint(equalTo: newsTableView.centerXAnchor),
            placeholder.centerYAnchor.constraint(equalTo: newsTableView.centerYAnchor),
            
            errorMessage.centerXAnchor.constraint(equalTo: newsTableView.centerXAnchor),
            errorMessage.centerYAnchor.constraint(equalTo: newsTableView.centerYAnchor),

            newsTableView.topAnchor.constraint(equalTo: buttonsStackView.bottomAnchor, constant: 20),
            newsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tableHeight = tableView.bounds.height
        let cellHeight = tableHeight / 2
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.articleSelectRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModel.updateImage(for: indexPath)
    }
}
