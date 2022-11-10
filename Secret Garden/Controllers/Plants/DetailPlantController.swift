//
//  DetailViewController.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 10.11.2022.
//

import UIKit

class DetailPlantController: DetailBaseController {
    
    let plant: Plant
    let plantLabel = UILabel()
        
    init(of plant: Plant) {
        self.plant = plant
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        
    }
    
    override func setupViews() {
        super.setupViews()
        
        plantImageView.image = plant.image.getImage()
        
        detailInfoView.addSubview(plantLabel)
        plantLabel.text = plant.name
        plantLabel.sizeToFit()
        
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        plantLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            plantLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            plantLabel.topAnchor.constraint(equalTo: detailInfoView.topAnchor, constant: 20)
        ])
    }
    
}
