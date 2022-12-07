//
//  DetailViewController.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 10.11.2022.
//

import UIKit

class DetailPlantController: DetailBaseController {
    
    private let plant: Plant
    
    let namePlant = UILabel()
    let latinName = UILabel()
    
    let originImage = UIImageView(image: Resources.Images.Characteristics.origin)
    let originLabel = UILabel()
    let originValue = UILabel()
    
    let temperatureImage = UIImageView(image: Resources.Images.Characteristics.temperature)
    let temperatureLabel = UILabel()
    let temperatureValue = UILabel()
    
    let ideaLightImage = UIImageView(image: Resources.Images.Characteristics.light)
    let idealLight = UILabel()
    let ideaLightValue = UILabel()
    
    let wateringImage = UIImageView(image: Resources.Images.Characteristics.humidity)
    let wateringLabel = UILabel()
    let wateringValue = UILabel()
    
    let insectsImage = UIImageView(image: Resources.Images.Characteristics.insects)
    let insectsLabel = UILabel()
    let insectsValue = UILabel()
        
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
        
        latinName.text = plant.characteristics?.latinName
        latinName.numberOfLines = 0
        latinName.font = Resources.Fonts.subHeaders
        latinName.textColor = Resources.Colors.subHeader
        detailInfoView.addSubview(latinName)
        
        idealLight.text = Resources.Strings.Common.Detail.light
        idealLight.numberOfLines = 0
        idealLight.font = Resources.Fonts.generalBold
        ideaLightValue.text = plant.characteristics?.idealLight ?? "No data"
        ideaLightValue.font = Resources.Fonts.general
        ideaLightValue.textAlignment = .right
        ideaLightValue.numberOfLines = 0
        ideaLightImage.contentMode = .scaleAspectFit
        detailInfoView.addSubview(ideaLightImage)
        detailInfoView.addSubview(idealLight)
        detailInfoView.addSubview(ideaLightValue)

        temperatureLabel.text = Resources.Strings.Common.Detail.temperature
        temperatureLabel.numberOfLines = 0
        temperatureLabel.font = Resources.Fonts.generalBold
        temperatureValue.text = plant.characteristics?.temperature ?? "No data"
        temperatureValue.font = Resources.Fonts.general
        temperatureValue.textAlignment = .right
        temperatureValue.numberOfLines = 0
        temperatureImage.contentMode = .scaleAspectFit
        detailInfoView.addSubview(temperatureImage)
        detailInfoView.addSubview(temperatureLabel)
        detailInfoView.addSubview(temperatureValue)

        wateringLabel.text = Resources.Strings.Common.Detail.humidity
        wateringLabel.numberOfLines = 0
        wateringLabel.font = Resources.Fonts.generalBold
        wateringValue.text = plant.characteristics?.watering ?? "No data"
        wateringValue.font = Resources.Fonts.general
        wateringValue.textAlignment = .right
        wateringValue.numberOfLines = 0
        wateringImage.contentMode = .scaleAspectFit
        detailInfoView.addSubview(wateringImage)
        detailInfoView.addSubview(wateringLabel)
        detailInfoView.addSubview(wateringValue)

        insectsLabel.text = Resources.Strings.Common.Detail.insects
        insectsLabel.numberOfLines = 0
        insectsLabel.font = Resources.Fonts.generalBold
        insectsValue.text = plant.characteristics?.insects ?? "No data"
        insectsValue.font = Resources.Fonts.general
        insectsValue.textAlignment = .right
        insectsValue.numberOfLines = 0
        insectsImage.contentMode = .scaleAspectFit
        detailInfoView.addSubview(insectsImage)
        detailInfoView.addSubview(insectsLabel)
        detailInfoView.addSubview(insectsValue)

        originLabel.text = Resources.Strings.Common.Detail.origin
        originLabel.numberOfLines = 0
        originLabel.font = Resources.Fonts.generalBold
        originValue.text = plant.characteristics?.origin ?? "No data"
        originValue.font = Resources.Fonts.general
        originValue.textAlignment = .right
        originValue.numberOfLines = 0
        originImage.contentMode = .scaleAspectFit
        detailInfoView.addSubview(originImage)
        detailInfoView.addSubview(originLabel)
        detailInfoView.addSubview(originValue)
        
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        namePlant.translatesAutoresizingMaskIntoConstraints = false
        latinName.translatesAutoresizingMaskIntoConstraints = false
        
        idealLight.translatesAutoresizingMaskIntoConstraints = false
        ideaLightImage.translatesAutoresizingMaskIntoConstraints = false

        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureImage.translatesAutoresizingMaskIntoConstraints = false

        wateringLabel.translatesAutoresizingMaskIntoConstraints = false
        wateringImage.translatesAutoresizingMaskIntoConstraints = false

        insectsImage.translatesAutoresizingMaskIntoConstraints = false
        insectsLabel.translatesAutoresizingMaskIntoConstraints = false

        originImage.translatesAutoresizingMaskIntoConstraints = false
        originLabel.translatesAutoresizingMaskIntoConstraints = false

        ideaLightValue.translatesAutoresizingMaskIntoConstraints = false
        temperatureValue.translatesAutoresizingMaskIntoConstraints = false
        wateringValue.translatesAutoresizingMaskIntoConstraints = false
        insectsValue.translatesAutoresizingMaskIntoConstraints = false
        originValue.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            namePlant.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            namePlant.topAnchor.constraint(equalTo: detailInfoView.topAnchor, constant: 20),
            
            latinName.topAnchor.constraint(equalTo: namePlant.bottomAnchor),
            latinName.leadingAnchor.constraint(equalTo: detailInfoView.leadingAnchor, constant: 20),
            
            ideaLightImage.topAnchor.constraint(equalTo: latinName.bottomAnchor, constant: 30),
            ideaLightImage.leadingAnchor.constraint(equalTo: detailInfoView.leadingAnchor, constant: 20),
            ideaLightImage.heightAnchor.constraint(equalTo: idealLight.heightAnchor),
            ideaLightImage.widthAnchor.constraint(equalTo: idealLight.heightAnchor),

            idealLight.topAnchor.constraint(equalTo: latinName.bottomAnchor, constant: 30),
            idealLight.leadingAnchor.constraint(equalTo: ideaLightImage.trailingAnchor, constant: 2),
            ideaLightValue.topAnchor.constraint(equalTo: idealLight.topAnchor),
            ideaLightValue.leadingAnchor.constraint(equalTo: idealLight.trailingAnchor, constant: 5),
            ideaLightValue.trailingAnchor.constraint(equalTo: detailInfoView.trailingAnchor, constant: -20),

            temperatureImage.topAnchor.constraint(equalTo: ideaLightValue.bottomAnchor, constant: 20),
            temperatureImage.leadingAnchor.constraint(equalTo: detailInfoView.leadingAnchor, constant: 20),
            temperatureImage.heightAnchor.constraint(equalTo: temperatureLabel.heightAnchor),
            temperatureImage.widthAnchor.constraint(equalTo: temperatureLabel.heightAnchor),

            temperatureLabel.topAnchor.constraint(equalTo: ideaLightValue.bottomAnchor, constant: 20),
            temperatureLabel.leadingAnchor.constraint(equalTo: temperatureImage.trailingAnchor, constant: 2),
            temperatureValue.topAnchor.constraint(equalTo: temperatureLabel.topAnchor),
            temperatureValue.leadingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor, constant: 5),
            temperatureValue.trailingAnchor.constraint(equalTo: detailInfoView.trailingAnchor, constant: -20),

            wateringImage.topAnchor.constraint(equalTo: temperatureValue.bottomAnchor, constant: 20),
            wateringImage.leadingAnchor.constraint(equalTo: detailInfoView.leadingAnchor, constant: 20),
            wateringImage.heightAnchor.constraint(equalTo: wateringLabel.heightAnchor),
            wateringImage.widthAnchor.constraint(equalTo: wateringLabel.heightAnchor),

            wateringLabel.topAnchor.constraint(equalTo: temperatureValue.bottomAnchor, constant: 20),
            wateringLabel.leadingAnchor.constraint(equalTo: wateringImage.trailingAnchor, constant: 2),
            wateringValue.topAnchor.constraint(equalTo: wateringLabel.topAnchor),
            wateringValue.leadingAnchor.constraint(equalTo: wateringLabel.trailingAnchor, constant: 5),
            wateringValue.trailingAnchor.constraint(equalTo: detailInfoView.trailingAnchor, constant: -20),

            insectsImage.topAnchor.constraint(equalTo: wateringValue.bottomAnchor, constant: 20),
            insectsImage.leadingAnchor.constraint(equalTo: detailInfoView.leadingAnchor, constant: 20),
            insectsImage.heightAnchor.constraint(equalTo: insectsLabel.heightAnchor),
            insectsImage.widthAnchor.constraint(equalTo: insectsLabel.heightAnchor),

            insectsLabel.topAnchor.constraint(equalTo: wateringValue.bottomAnchor, constant: 20),
            insectsLabel.leadingAnchor.constraint(equalTo: insectsImage.trailingAnchor, constant: 2),
            insectsValue.topAnchor.constraint(equalTo: insectsLabel.topAnchor),
            insectsValue.leadingAnchor.constraint(equalTo: insectsLabel.trailingAnchor, constant: 5),
            insectsValue.trailingAnchor.constraint(equalTo: detailInfoView.trailingAnchor, constant: -20),

            originImage.topAnchor.constraint(equalTo: insectsValue.bottomAnchor, constant: 20),
            originImage.leadingAnchor.constraint(equalTo: detailInfoView.leadingAnchor, constant: 20),
            originImage.heightAnchor.constraint(equalTo: originLabel.heightAnchor),
            originImage.widthAnchor.constraint(equalTo: originLabel.heightAnchor),

            originLabel.topAnchor.constraint(equalTo: insectsValue.bottomAnchor, constant: 20),
            originLabel.leadingAnchor.constraint(equalTo: originImage.trailingAnchor, constant: 2),
            originValue.topAnchor.constraint(equalTo: originLabel.topAnchor),
            originValue.leadingAnchor.constraint(equalTo: originLabel.trailingAnchor, constant: 5),
            originValue.trailingAnchor.constraint(equalTo: detailInfoView.trailingAnchor, constant: -20),
        ])
    }
}
