//
//  EditPlantViewController.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 06.11.2022.
//

import UIKit

final class EditPlantViewController: DetailBaseController {
    
    private let viewModel: EditPlantViewModelProtocol
    
    lazy private var nameLabel = createLabel(text: Resources.Strings.Common.name,
                                             textColor: Resources.Colors.blackOnWhite,
                                             font: Font.subHeader)
    lazy private var validStatusLabel = createLabel(text: "",
                                                    textColor: .systemRed,
                                                    font: Font.generalLight)
    lazy private var nameTextField = createTextField(placeholder: "")
    
    lazy private var imageLabel = createLabel(text: "Image",
                                              textColor: Resources.Colors.blackOnWhite,
                                              font: Font.subHeader)
    lazy private var chooseImageButton = createButton(isBase: false,
                                                      title: "Choose new",
                                                      selector: #selector(addNewPhotoTapped))
    lazy private var saveButton = createButton(isBase: true,
                                               title: Resources.Strings.Common.save,
                                               selector: #selector(saveButtonTapped))
    
    init(viewModel: EditPlantViewModelProtocol) {
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
        updateValidStatus()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        viewModel.viewWillDisappear()
    }
    
    override func setupUI() {
        super.setupUI()
        
        nameTextField.text = viewModel.viewData.plantTitle
        imageView.image = viewModel.viewData.plantImage
        nameTextField.delegate = self
    }
    
    private func updateValidStatus() {
        viewModel.validateCompletion = { [weak self] statusText in
            self?.validStatusLabel.text = statusText
        }
        viewModel.updateImageCompletion = { [weak self] image in
            self?.imageView.image = image
        }
    }
    
    @objc private func saveButtonTapped() {
        viewModel.saveButtonTapped(name: nameTextField.text, image: imageView.image)
    }
    @objc private func addNewPhotoTapped() {
        viewModel.addNewPhotoTapped()
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: detailView.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: detailView.leadingAnchor, constant: 20),
            
            validStatusLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 10),
            validStatusLabel.bottomAnchor.constraint(equalTo: nameTextField.topAnchor, constant: -5),
            validStatusLabel.trailingAnchor.constraint(equalTo: detailView.trailingAnchor, constant: -20),
            
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            nameTextField.leadingAnchor.constraint(equalTo: detailView.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: detailView.trailingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            imageLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10),
            imageLabel.leadingAnchor.constraint(equalTo: detailView.leadingAnchor, constant: 20),
            
            chooseImageButton.topAnchor.constraint(equalTo: imageLabel.bottomAnchor, constant: 5),
            chooseImageButton.leadingAnchor.constraint(equalTo: detailView.leadingAnchor, constant: 20),
            chooseImageButton.widthAnchor.constraint(equalToConstant: 100),
            chooseImageButton.heightAnchor.constraint(equalToConstant: 30),
            
            saveButton.centerXAnchor.constraint(equalTo: detailView.centerXAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: 50),
            saveButton.widthAnchor.constraint(equalToConstant: 150),
            saveButton.topAnchor.constraint(equalTo: chooseImageButton.bottomAnchor, constant: 20)
        ])
    }
}

// MARK: - UITextFieldDelegate

extension EditPlantViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacter = CharacterSet.letters
        let allowedCharacter1 = CharacterSet.whitespaces
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacter.isSuperset(of: characterSet) || allowedCharacter1.isSuperset(of: characterSet)
    }
}
