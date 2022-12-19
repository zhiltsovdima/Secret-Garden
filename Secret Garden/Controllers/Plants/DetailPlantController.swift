//
//  DetailViewController.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 10.11.2022.
//

import UIKit

final class DetailPlantController: DetailBaseController {
    
    private var plant: Plant?
    
    private var characteristicsValues = [String]()
    private var characteristicsNames = [String]()
    
    private let tableView = UITableView()
    
    private let namePlant = UILabel()
    private let latinName = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
    }
    
    func setPlant(_ plant: Plant?) {
        self.plant = plant
        self.characteristicsValues = plant?.characteristics?.getArrayOfValues() ?? []
        self.characteristicsNames = Resources.Strings.Common.Detail.all
    }
    
    func updateUI() {
        latinName.text = plant?.characteristics?.latinName
        tableView.reloadData()
    }
    
    override func setupViews() {
        super.setupViews()
        
        tableView.register(CharacteristicCell.self, forCellReuseIdentifier: Resources.Identifiers.characteristicCell)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.isScrollEnabled = false
        detailInfoView.addSubview(tableView)
        
        plantImageView.image = plant?.image.getImage()
        
        namePlant.text = plant?.name
        namePlant.numberOfLines = 0
        namePlant.font = Resources.Fonts.header
        detailInfoView.addSubview(namePlant)
        
        latinName.text = plant?.characteristics?.latinName
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
        
        NSLayoutConstraint.activate([
            namePlant.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            namePlant.topAnchor.constraint(equalTo: detailInfoView.topAnchor, constant: 20),
            
            latinName.topAnchor.constraint(equalTo: namePlant.bottomAnchor),
            latinName.leadingAnchor.constraint(equalTo: detailInfoView.leadingAnchor, constant: 20),
            
            tableView.topAnchor.constraint(equalTo: latinName.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: detailInfoView.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: detailInfoView.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: detailInfoView.bottomAnchor)
        ])
    }
}

extension DetailPlantController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characteristicsValues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Resources.Identifiers.characteristicCell, for: indexPath) as! CharacteristicCell
        
        let value = characteristicsValues[indexPath.row]
        let name = characteristicsNames[indexPath.row]
        cell.set(characteristicName: name, characteristicValue: value)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
