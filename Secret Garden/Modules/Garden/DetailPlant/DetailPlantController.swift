//
//  DetailViewController.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 10.11.2022.
//

import UIKit

final class DetailPlantController: DetailBaseController {
        
    private let viewModel: DetailPlantViewModelProtocol
    
    private let tableView = UITableView()
    private let spinner = UIActivityIndicatorView()

    lazy private var namePlant = createLabel(text: viewModel.viewData.name,
                                             textColor: Resources.Colors.blackOnWhite,
                                             font: Font.header)
    lazy private var latinName = createLabel(text: viewModel.viewData.latinName,
                                             textColor: Resources.Colors.blackOnWhite,
                                             font: Font.thinText)
    lazy private var errorMessage = createLabel(text: viewModel.viewData.errorMessage,
                                                textColor: Resources.Colors.blackOnWhite,
                                                font: Font.generalBold)
    
    init(viewModel: DetailPlantViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        updateUI()
        setupConstraints()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        viewModel.viewWillDisappear()
    }
    
    func updateUI() {
        viewModel.updateCompletion = { [weak self] isSuccess in
            DispatchQueue.main.async {
                self?.spinner.stopAnimating()
                switch isSuccess {
                case true:
                    self?.latinName.text = self?.viewModel.viewData.latinName
                    self?.tableView.isHidden = false
                    self?.tableView.reloadData()
                case false:
                    self?.errorMessage.text = self?.viewModel.viewData.errorMessage
                    self?.errorMessage.isHidden = false
                }
            }
        }
        viewModel.updateFeatures()
    }
    
    override func setupUI() {
        super.setupUI()
        
        plantImageView.image = viewModel.viewData.image
        
        detailView.addSubview(spinner)
        spinner.startAnimating()
        spinner.hidesWhenStopped = true
        
        errorMessage.isHidden = true
        
        tableView.register(FeatureCell.self, forCellReuseIdentifier: Resources.Identifiers.featureCell)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.isScrollEnabled = false
        tableView.isHidden = true
        tableView.backgroundColor = Resources.Colors.backgroundColor
        detailView.addSubview(tableView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        spinner.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            namePlant.leadingAnchor.constraint(equalTo: detailView.leadingAnchor, constant: 20),
            namePlant.topAnchor.constraint(equalTo: detailView.topAnchor, constant: 20),
            
            latinName.topAnchor.constraint(equalTo: namePlant.bottomAnchor),
            latinName.leadingAnchor.constraint(equalTo: detailView.leadingAnchor, constant: 20),
            
            tableView.topAnchor.constraint(equalTo: latinName.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: detailView.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: detailView.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: detailView.bottomAnchor),
            
            spinner.centerXAnchor.constraint(equalTo: detailView.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: detailView.centerYAnchor),
            errorMessage.centerXAnchor.constraint(equalTo: detailView.centerXAnchor),
            errorMessage.centerYAnchor.constraint(equalTo: detailView.centerYAnchor)
        ])
    }
}

extension DetailPlantController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Resources.Identifiers.featureCell, for: indexPath) as! FeatureCell
        cell.setup(with: viewModel.tableData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
