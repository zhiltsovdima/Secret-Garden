//
//  AddPlantController.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 01.11.2022.
//

import UIKit

protocol AddPlantControllerProtocol: AnyObject {
    
}

final class AddPlantController: UIViewController {
    
    private let viewModel: AddPlantViewModelProtocol
    
    lazy private var plantImageView = createImageView()
    lazy private var nameLabel = createLabel(text: Resources.Strings.Common.name,
                                             textColor: Resources.Colors.blackOnWhite,
                                             font: Resources.Fonts.generalBold)
    lazy private var nameTextField = createTextField()
    lazy private var validStatusLabel = createLabel(text: "",
                                                    textColor: .systemRed,
                                                    font: Resources.Fonts.generalBold?.withSize(12))
    lazy private var examplePlantsLabel = createLabel(text: Resources.Strings.AddPlant.examplePlant,
                                                      textColor: UIColor.lightGray,
                                                      font: Resources.Fonts.subHeaders)
    lazy private var saveButton = createButton()
        
    init(viewModel: AddPlantViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
        setUpdatesUI()
        configureTapGesture(to: plantImageView)
        configureTapGesture(to: view)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        viewModel.viewWillDisappear()
    }
    
    private func setupUI() {
        title = Resources.Strings.AddPlant.titleController
        view.backgroundColor = Resources.Colors.backgroundColor
    }

    private func setUpdatesUI() {
        viewModel.validateCompletion = { [weak self] statusText in
            self?.validStatusLabel.text = statusText
        }
        viewModel.updateImageCompletion = { [weak self] image in
            self?.plantImageView.image = image
        }
    }
    
    @objc private func saveButtonTapped() {
        viewModel.saveButtonTapped(name: nameTextField.text, image: plantImageView.image)
    }
    
    @objc private func handleTap() {
        view.endEditing(true)
    }
    @objc private func addPhotoTapped() {
        viewModel.addNewPhotoTapped()
    }
}

// MARK: - Views Settings

extension AddPlantController {
    
    private func createLabel(text: String, textColor: UIColor?, font: UIFont?) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = textColor
        label.font = font
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        return label
    }
    
    private func createButton() -> UIButton {
        let button = BaseButton()
        button.setTitle(Resources.Strings.Common.save, for: .normal)
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        return button
    }
    
    private func createImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = Resources.Images.Common.camera
        imageView.tintColor = Resources.Colors.accent
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        return imageView
    }
    
    private func createTextField() -> UITextField {
        let textField = UITextField()
        textField.delegate = self
        textField.textColor = Resources.Colors.blackOnWhite
        textField.font = Resources.Fonts.general
        textField.backgroundColor = Resources.Colors.backgroundFields
        textField.placeholder = Resources.Strings.AddPlant.placeholder
        textField.adjustsFontSizeToFitWidth = true
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textField)
        return textField
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            plantImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            plantImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            plantImageView.heightAnchor.constraint(equalToConstant: 200),
            plantImageView.widthAnchor.constraint(equalToConstant: 200),

            nameLabel.topAnchor.constraint(equalTo: plantImageView.bottomAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            validStatusLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 10),
            validStatusLabel.bottomAnchor.constraint(equalTo: nameTextField.topAnchor, constant: -5),
            validStatusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            examplePlantsLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 5),
            examplePlantsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            examplePlantsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: 50),
            saveButton.widthAnchor.constraint(equalToConstant: 150),
            saveButton.topAnchor.constraint(equalTo: examplePlantsLabel.bottomAnchor, constant: 10)
        ])
    }
}

// MARK: - UITextFieldDelegate

extension AddPlantController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacter = CharacterSet.letters
        let allowedCharacter1 = CharacterSet.whitespaces
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacter.isSuperset(of: characterSet) || allowedCharacter1.isSuperset(of: characterSet)
    }
}

// MARK: - TapGestureRecognizer

extension AddPlantController {
    
    private func configureTapGesture(to selectedView: UIView) {
        if let imageView = selectedView as? UIImageView {
            imageView.isUserInteractionEnabled = true
            imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addPhotoTapped)))
        } else {
            selectedView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        }
    }
}
