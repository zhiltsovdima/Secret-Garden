//
//  CartCell.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 26.11.2022.
//

import UIKit

final class CartCellViewModel {
    var id: String
    var name: String
    var price: String
    var image: UIImage?
    var count: Int
    
    var updateCountCompletion: ((Int) -> Void)?
    
    init(id: String, name: String, price: String, image: UIImage? = nil, count: Int, updateCountCompletion: ((Int) -> Void)? = nil) {
        self.id = id
        self.name = name
        self.price = price
        self.image = image
        self.count = count
        self.updateCountCompletion = updateCountCompletion
    }
    
    func update(count: Int) {
        self.count = count
        updateCountCompletion?(self.count)
    }
}

final class CartCell: UITableViewCell {
    
    private var model: CartCellViewModel?
    
    private let nameItem = UILabel()
    private let priceLabel = UILabel()
    private let itemImageView = UIImageView()
    private let deleteButton = UIButton()

    lazy private var stepper: ItemStepper = {
        let viewData = ItemStepper.ViewData(minimum: 1, maximum: 100, stepValue: 1)
        let stepper = ItemStepper(viewData: viewData)
        stepper.addTarget(self, action: #selector(stepperValueChanged), for: .valueChanged)
        return stepper
    }()
    
    var removeFromCartCompletion: ((UITableViewCell) -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with model: CartCellViewModel) {
        self.model = model
        nameItem.text = model.name
        priceLabel.text = model.price
        itemImageView.image = model.image
        stepper.setup(value: model.count)
    }
    
    @objc func deleteFromCartAction() {
        removeFromCartCompletion?(self)
    }
    
    @objc func stepperValueChanged() {
        model?.update(count: stepper.value)
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        backgroundColor = Resources.Colors.backgroundColor

        addSubview(itemImageView)
        addSubview(priceLabel)
        addSubview(nameItem)
        contentView.addSubview(deleteButton)
        contentView.addSubview(stepper)
        
        itemImageView.layer.cornerRadius = 10
        itemImageView.clipsToBounds = true
        itemImageView.contentMode = .scaleAspectFill
 
        nameItem.numberOfLines = 0
        nameItem.font = Resources.Fonts.general
        
        priceLabel.numberOfLines = 0
        priceLabel.font = Resources.Fonts.generalBold
        
        deleteButton.setImage(Resources.Images.Common.delete, for: .normal)
        deleteButton.tintColor = Resources.Colors.blackOnWhite
        deleteButton.addTarget(self, action: #selector(deleteFromCartAction), for: .touchUpInside)
        deleteButton.makeSystemAnimation()
    }
    
    private func setupConstraints() {
        [itemImageView, priceLabel, nameItem, deleteButton, stepper].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            itemImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            itemImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            itemImageView.widthAnchor.constraint(equalToConstant: 130),
            itemImageView.heightAnchor.constraint(equalToConstant: 130),
        
            nameItem.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            nameItem.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 10),
            nameItem.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            
            priceLabel.topAnchor.constraint(equalTo: nameItem.bottomAnchor, constant: 20),
            priceLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 10),
            
            deleteButton.topAnchor.constraint(equalTo: stepper.topAnchor),
            deleteButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            deleteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            stepper.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 10),
            stepper.bottomAnchor.constraint(equalTo: itemImageView.bottomAnchor)
        ])
    }
    
}
