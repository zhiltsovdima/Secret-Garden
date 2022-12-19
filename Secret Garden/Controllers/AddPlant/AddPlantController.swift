//
//  AddPlantController.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 01.11.2022.
//

import UIKit

final class AddPlantController: BaseViewController {
    
    private let plantImageView = UIImageView()
    private let nameLabel = UILabel()
    private let viewForTextField = UIView()
    private let nameTextField = UITextField()
    private let saveButton = BaseButton()
    
    private let notValidNewPlant = UILabel()
    private let examplePlant = UILabel()
    
    private var plantImage: UIImage? {
        return plantImageView.image != Resources.Images.Common.camera ? plantImageView.image : nil
    }
    private var plantName: String? {
        return nameTextField.hasText ? nameTextField.text : nil
    }
    
    var completionHandler: ((Plant) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Resources.Strings.AddPlant.titleController
        setupViews()
        setConstraints()
        configureTapGesture(to: plantImageView)
        configureTapGesture(to: view)
        configureTextField()
    }
    
    private func validateNewPlant(name: String?, image: UIImage?) -> Bool {
        if name != nil, image != nil {
            return true
        } else if name == nil && image == nil {
            notValidNewPlant.text = Resources.Strings.AddPlant.emptyName + "\n" + Resources.Strings.AddPlant.emptyImage
            notValidNewPlant.isHidden = false
            return false
        } else if image == nil {
            notValidNewPlant.text = Resources.Strings.AddPlant.emptyImage
            notValidNewPlant.isHidden = false
            return false
        } else {
            notValidNewPlant.text = Resources.Strings.AddPlant.emptyName
            notValidNewPlant.isHidden = false
            return false
        }
    }
    
    @objc private func saveButtonTapped() {
        let isValidate = validateNewPlant(name: plantName, image: plantImage)
        if isValidate {
            let plant = Plant(name: plantName!, image: PlantImage(plantImage!))
            completionHandler?(plant)
            navigationController?.popViewController(animated: true)
        }
    }
    @objc private func handleTap() {
        view.endEditing(true)
    }
    @objc private func tapPhoto() {
        choosePhotoAlert()
    }
}

// MARK: - Views Settings

extension AddPlantController {
    
    private func setupViews() {
        view.addSubview(plantImageView)
        plantImageView.image = Resources.Images.Common.camera
        plantImageView.tintColor = Resources.Colors.accent
        plantImageView.contentMode = .scaleAspectFit
        
        view.addSubview(nameLabel)
        nameLabel.text = Resources.Strings.Common.name
        nameLabel.font = Resources.Fonts.generalBold
        nameLabel.textColor = .black
        
        view.addSubview(viewForTextField)
        viewForTextField.backgroundColor = Resources.Colors.backgroundFields
        viewForTextField.layer.borderColor = UIColor.lightGray.cgColor
        viewForTextField.layer.borderWidth = 0.5
        viewForTextField.layer.cornerRadius = 5
        
        view.addSubview(nameTextField)
        nameTextField.textColor = .black
        nameTextField.font = Resources.Fonts.general
        nameTextField.backgroundColor = Resources.Colors.backgroundFields
        nameTextField.placeholder = Resources.Strings.AddPlant.placeholder
        
        view.addSubview(notValidNewPlant)
        notValidNewPlant.font = Resources.Fonts.general?.withSize(12)
        notValidNewPlant.numberOfLines = 0
        notValidNewPlant.textColor = .red
        notValidNewPlant.isHidden = true
        
        view.addSubview(examplePlant)
        examplePlant.font = Resources.Fonts.subHeaders
        examplePlant.textColor = .lightGray
        examplePlant.text = Resources.Strings.AddPlant.examplePlant
        
        view.addSubview(saveButton)
        saveButton.setTitle(Resources.Strings.Common.save, for: .normal)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    private func setConstraints() {
        let saveArea = view.safeAreaLayoutGuide

        plantImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        viewForTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        notValidNewPlant.translatesAutoresizingMaskIntoConstraints = false
        examplePlant.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            plantImageView.topAnchor.constraint(equalTo: saveArea.topAnchor, constant: 20),
            plantImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            plantImageView.heightAnchor.constraint(equalToConstant: 200),
            plantImageView.widthAnchor.constraint(equalToConstant: 200),

            nameLabel.topAnchor.constraint(equalTo: plantImageView.bottomAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            viewForTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            viewForTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            viewForTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            viewForTextField.heightAnchor.constraint(equalToConstant: 40),
            
            nameTextField.topAnchor.constraint(equalTo: viewForTextField.topAnchor, constant: 5),
            nameTextField.leadingAnchor.constraint(equalTo: viewForTextField.leadingAnchor, constant: 5),
            nameTextField.trailingAnchor.constraint(equalTo: viewForTextField.trailingAnchor, constant: -5),
            nameTextField.bottomAnchor.constraint(equalTo: viewForTextField.bottomAnchor, constant: -5),
            
            notValidNewPlant.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 10),
            notValidNewPlant.bottomAnchor.constraint(equalTo: viewForTextField.topAnchor, constant: -5),
            notValidNewPlant.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            examplePlant.topAnchor.constraint(equalTo: viewForTextField.bottomAnchor, constant: 5),
            examplePlant.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            examplePlant.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: 50),
            saveButton.widthAnchor.constraint(equalToConstant: 150),
            saveButton.topAnchor.constraint(equalTo: examplePlant.bottomAnchor, constant: 10)
        ])
    }
    
    private func configureTextField() {
        nameTextField.delegate = self
    }
}

// MARK: - UITextFieldDelegate

extension AddPlantController: UITextFieldDelegate {
        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.hasText {
            textField.resignFirstResponder()
            notValidNewPlant.isHidden = true
            return true
        } else {
            notValidNewPlant.text = Resources.Strings.AddPlant.emptyName
            notValidNewPlant.isHidden = false
            return false
        }
    }
    
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
            imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapPhoto)))
        } else {
            selectedView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        }
    }
}

// MARK: - UIImagePickerController
extension AddPlantController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private func showImagePickerController(sourceType: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = sourceType
        present(imagePickerController, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            plantImageView.image = originalImage
            notValidNewPlant.isHidden = true
        }
        dismiss(animated: true)
    }
}

// MARK: - UIAlertController
extension AddPlantController {
    
    private func choosePhotoAlert() {
        let alertController = UIAlertController(title: Resources.Strings.AddPlant.titleAlert, message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: Resources.Strings.AddPlant.camera, style: .default) { [weak self] action in
            self?.showImagePickerController(sourceType: .camera)
        }
        let photoLibraryAction = UIAlertAction(title: Resources.Strings.AddPlant.photoLibrary, style: .default) { [weak self] action in
            self?.showImagePickerController(sourceType: .photoLibrary)
        }
        let cancelAction = UIAlertAction(title: Resources.Strings.Common.cancel, style: .cancel)
        
        alertController.addAction(cameraAction)
        alertController.addAction(photoLibraryAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
}
