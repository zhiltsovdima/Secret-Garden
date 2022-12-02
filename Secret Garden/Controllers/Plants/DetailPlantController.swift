//
//  DetailViewController.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 10.11.2022.
//

import UIKit

class DetailPlantController: DetailBaseController {
    
    let plant: Plant
    
    let namePlant = UILabel()
    let latinName = UILabel()
    
    let originImage = UIImageView(image: Resources.Images.Characteristics.origin)
    let originLabel = UILabel()
    
    let temperatureImage = UIImageView(image: Resources.Images.Characteristics.temperature)
    let temperatureLabel = UILabel()
    
    let ideaLightImage = UIImageView(image: Resources.Images.Characteristics.light)
    let ideaLight = UILabel()
    
    let wateringImage = UIImageView(image: Resources.Images.Characteristics.humidity)
    let wateringLabel = UILabel()
    
    let insectsImage = UIImageView(image: Resources.Images.Characteristics.insects)
    let insectsLabel = UILabel()
        
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
        
        namePlant.text = plant.name
        namePlant.numberOfLines = 0
        namePlant.font = Resources.Fonts.header
        detailInfoView.addSubview(namePlant)
        
        latinName.text = "latin"
        latinName.numberOfLines = 0
        latinName.font = Resources.Fonts.subHeaders
        latinName.textColor = Resources.Colors.subHeader
        detailInfoView.addSubview(latinName)
        
        ideaLight.text = "ideaLight"
        ideaLight.numberOfLines = 0
        ideaLight.font = Resources.Fonts.generalBold
        detailInfoView.addSubview(ideaLightImage)
        detailInfoView.addSubview(ideaLight)
        
        temperatureLabel.text = Resources.Strings.Common.Detail.temperature
        temperatureLabel.numberOfLines = 0
        temperatureLabel.font = Resources.Fonts.generalBold
        detailInfoView.addSubview(temperatureImage)
        detailInfoView.addSubview(temperatureLabel)
        
        wateringLabel.text = Resources.Strings.Common.Detail.humidity
        wateringLabel.numberOfLines = 0
        wateringLabel.font = Resources.Fonts.generalBold
        detailInfoView.addSubview(wateringImage)
        detailInfoView.addSubview(wateringLabel)
        
        insectsLabel.text = Resources.Strings.Common.Detail.insects
        insectsLabel.numberOfLines = 0
        insectsLabel.font = Resources.Fonts.generalBold
        detailInfoView.addSubview(insectsImage)
        detailInfoView.addSubview(insectsLabel)
        
        originLabel.text = Resources.Strings.Common.Detail.origin
        originLabel.numberOfLines = 0
        originLabel.font = Resources.Fonts.generalBold
        detailInfoView.addSubview(originImage)
        detailInfoView.addSubview(originLabel)
        
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        namePlant.translatesAutoresizingMaskIntoConstraints = false
        latinName.translatesAutoresizingMaskIntoConstraints = false
        
        ideaLight.translatesAutoresizingMaskIntoConstraints = false
        ideaLightImage.translatesAutoresizingMaskIntoConstraints = false
        
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureImage.translatesAutoresizingMaskIntoConstraints = false
        
        wateringLabel.translatesAutoresizingMaskIntoConstraints = false
        wateringImage.translatesAutoresizingMaskIntoConstraints = false
        
        insectsImage.translatesAutoresizingMaskIntoConstraints = false
        insectsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        originImage.translatesAutoresizingMaskIntoConstraints = false
        originLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            namePlant.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            namePlant.topAnchor.constraint(equalTo: detailInfoView.topAnchor, constant: 20),
            
            latinName.topAnchor.constraint(equalTo: namePlant.bottomAnchor),
            latinName.leadingAnchor.constraint(equalTo: detailInfoView.leadingAnchor, constant: 20),
            
            ideaLightImage.topAnchor.constraint(equalTo: latinName.bottomAnchor, constant: 30),
            ideaLightImage.leadingAnchor.constraint(equalTo: detailInfoView.leadingAnchor, constant: 20),
            
            ideaLight.topAnchor.constraint(equalTo: latinName.bottomAnchor, constant: 30),
            ideaLight.leadingAnchor.constraint(equalTo: ideaLightImage.trailingAnchor, constant: 2),
            
            temperatureImage.topAnchor.constraint(equalTo: ideaLight.bottomAnchor, constant: 20),
            temperatureImage.leadingAnchor.constraint(equalTo: detailInfoView.leadingAnchor, constant: 20),
            
            temperatureLabel.topAnchor.constraint(equalTo: ideaLight.bottomAnchor, constant: 20),
            temperatureLabel.leadingAnchor.constraint(equalTo: temperatureImage.trailingAnchor, constant: 2),
            
            wateringImage.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 20),
            wateringImage.leadingAnchor.constraint(equalTo: detailInfoView.leadingAnchor, constant: 20),
            
            wateringLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 20),
            wateringLabel.leadingAnchor.constraint(equalTo: wateringImage.trailingAnchor, constant: 2),
            
            insectsImage.topAnchor.constraint(equalTo: wateringLabel.bottomAnchor, constant: 20),
            insectsImage.leadingAnchor.constraint(equalTo: detailInfoView.leadingAnchor, constant: 20),
            
            insectsLabel.topAnchor.constraint(equalTo: wateringLabel.bottomAnchor, constant: 20),
            insectsLabel.leadingAnchor.constraint(equalTo: insectsImage.trailingAnchor, constant: 2),
            
            originImage.topAnchor.constraint(equalTo: insectsLabel.bottomAnchor, constant: 20),
            originImage.leadingAnchor.constraint(equalTo: detailInfoView.leadingAnchor, constant: 20),
            
            originLabel.topAnchor.constraint(equalTo: insectsLabel.bottomAnchor, constant: 20),
            originLabel.leadingAnchor.constraint(equalTo: originImage.trailingAnchor, constant: 2),
        ])
    }
    
}
