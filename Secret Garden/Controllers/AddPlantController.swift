//
//  AddPlantController.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 01.11.2022.
//

import UIKit

final class AddPlantController: BaseViewController {
    
    let imageView = UIImageView()
    let nameTextField = UITextField()
    let nameView = UIView()
    let nameLabel = UILabel()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        hidesBottomBarWhenPushed = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setupViews()
        constraintViews()
    }
    
    private func setupViews() {
        view.addSubview(imageView)
        imageView.image = Resources.Images.Common.camera
        imageView.tintColor = Resources.Colors.accent
        imageView.contentMode = .scaleAspectFit
        
        view.addSubview(nameLabel)
        nameLabel.text = Resources.Strings.Common.name
        nameLabel.textColor = .black
        
        view.addSubview(nameView)
        nameView.backgroundColor = Resources.Colors.tabBarColor
        
        view.addSubview(nameTextField)
        nameTextField.textColor = .black
        nameTextField.backgroundColor = Resources.Colors.tabBarColor
    }
    
    private func constraintViews() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        nameView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            nameView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: nameView.topAnchor, constant: 5),
            nameTextField.leadingAnchor.constraint(equalTo: nameView.leadingAnchor, constant: 5),
            nameTextField.trailingAnchor.constraint(equalTo: nameView.trailingAnchor, constant: -5),
            nameTextField.bottomAnchor.constraint(equalTo: nameView.bottomAnchor, constant: -5)
        ])
    }
}
