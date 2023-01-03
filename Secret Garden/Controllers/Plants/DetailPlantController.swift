//
//  DetailViewController.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 10.11.2022.
//

import UIKit

final class DetailPlantController: DetailBaseController {
    
    private var plant: Plant?
    
    private var featuresNames = Resources.Strings.Common.Detail.all
    private var featuresValues: [String] = []
    
    private let tableView = UITableView()
    
    private let namePlant = UILabel()
    private let latinName = UILabel()
    
    private let spinner = UIActivityIndicatorView()
    private let errorMessage = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
    }
    
    func setPlant(_ plant: Plant?) {
        self.plant = plant
        
        plant?.downloadFeatures(completion: { [weak self] features, errorMessage in
            DispatchQueue.main.async {
                guard let features else {
                    self?.errorMessage.text = errorMessage
                    self?.updateUI()
                    return
                }
                let insects = features.insects.joined(separator: ", ")
                self?.featuresValues = [features.idealLight,
                                        features.temperature,
                                        features.watering,
                                        insects,
                                        features.origin]
                self?.updateUI()
            }
        })
    }
    
    private func createNetworkManager() -> NetworkManagerProtocol {
        let networkManager = NetworkManager()
        return networkManager
    }
    
    private func updateUI() {
        switch featuresValues.isEmpty {
        case true:
            spinner.stopAnimating()
            spinner.isHidden = true
            errorMessage.isHidden = false
        case false:
            latinName.text = plant?.features?.latinName
            tableView.reloadData()
            tableView.isHidden = false
            spinner.stopAnimating()
            spinner.isHidden = true
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        detailInfoView.addSubview(spinner)
        spinner.startAnimating()
        detailInfoView.addSubview(errorMessage)
        errorMessage.isHidden = true
        errorMessage.font = Resources.Fonts.generalBold
        
        tableView.register(FeatureCell.self, forCellReuseIdentifier: Resources.Identifiers.featureCell)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.isScrollEnabled = false
        tableView.isHidden = true
        tableView.backgroundColor = Resources.Colors.backgroundColor
        detailInfoView.addSubview(tableView)
        
        plantImageView.image = plant?.imageData.image
        
        namePlant.text = plant?.name
        namePlant.numberOfLines = 0
        namePlant.font = Resources.Fonts.header
        detailInfoView.addSubview(namePlant)
        
        latinName.numberOfLines = 0
        latinName.font = Resources.Fonts.subHeaders
        latinName.textColor = Resources.Colors.subHeader
        detailInfoView.addSubview(latinName)
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        namePlant.translatesAutoresizingMaskIntoConstraints = false
        latinName.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        spinner.translatesAutoresizingMaskIntoConstraints = false
        errorMessage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            namePlant.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            namePlant.topAnchor.constraint(equalTo: detailInfoView.topAnchor, constant: 20),
            
            latinName.topAnchor.constraint(equalTo: namePlant.bottomAnchor),
            latinName.leadingAnchor.constraint(equalTo: detailInfoView.leadingAnchor, constant: 20),
            
            tableView.topAnchor.constraint(equalTo: latinName.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: detailInfoView.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: detailInfoView.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: detailInfoView.bottomAnchor),
            
            spinner.centerXAnchor.constraint(equalTo: detailInfoView.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: detailInfoView.centerYAnchor),
            errorMessage.centerXAnchor.constraint(equalTo: detailInfoView.centerXAnchor),
            errorMessage.centerYAnchor.constraint(equalTo: detailInfoView.centerYAnchor)
        ])
    }
}

extension DetailPlantController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return featuresValues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Resources.Identifiers.featureCell, for: indexPath) as! FeatureCell
        
        let value = featuresValues[indexPath.row]
        let name = featuresNames[indexPath.row]
        cell.set(featureName: name, featureValue: value)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
