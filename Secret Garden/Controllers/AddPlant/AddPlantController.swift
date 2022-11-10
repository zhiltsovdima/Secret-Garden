//
//  AddPlantController.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 01.11.2022.
//

import UIKit

class AddPlantController: BaseViewController {
    
    let plantImageView = UIImageView()
    let nameTextField = UITextField()
    let nameView = UIView()
    let nameLabel = UILabel()
    let saveButton = BaseButton()
    
    var plantImage: UIImage? {
        return plantImageView.image
    }
    var plantName: String? {
        return nameTextField.text
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
    
    private func setupViews() {
        view.addSubview(plantImageView)
        plantImageView.image = Resources.Images.Common.camera
        plantImageView.tintColor = Resources.Colors.accent
        plantImageView.contentMode = .scaleAspectFit
        
        view.addSubview(nameLabel)
        nameLabel.text = Resources.Strings.Common.name
        nameLabel.textColor = .black
        
        view.addSubview(nameView)
        nameView.backgroundColor = Resources.Colors.backgroundFields
        nameView.layer.borderColor = UIColor.lightGray.cgColor
        nameView.layer.borderWidth = 0.5
        nameView.layer.cornerRadius = 5
        
        view.addSubview(nameTextField)
        nameTextField.textColor = .black
        nameTextField.backgroundColor = Resources.Colors.backgroundFields
        nameTextField.placeholder = Resources.Strings.AddPlant.placeholder
        
        view.addSubview(saveButton)
        saveButton.setTitle(Resources.Strings.Common.save, for: .normal)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    private func setConstraints() {
        let saveArea = view.safeAreaLayoutGuide

        plantImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            plantImageView.topAnchor.constraint(equalTo: saveArea.topAnchor, constant: 20),
            plantImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            plantImageView.heightAnchor.constraint(equalToConstant: 200),
            plantImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: plantImageView.bottomAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        nameView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
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
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: 50),
            saveButton.widthAnchor.constraint(equalToConstant: 150),
            saveButton.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 20)
        ])
    }
    
    @objc private func saveButtonTapped() {
        if let plantName, let plantImage, plantImage != Resources.Images.Common.camera {
            
            let plant = Plant(name: plantName, image: PlantImage(plantImage))
            completionHandler?(plant)
            navigationController?.popViewController(animated: true)
        } else {
            // FIXME: add a somethimg visual
            print("Error, you need to add a name and an image")
        }
    }
    
    private func configureTextField() {
        nameTextField.delegate = self
    }
    
    @objc private func handleTap() {
        view.endEditing(true)
    }
    @objc private func tapPhoto() {
        choosePhotoAlert()
    }
}

// MARK: - UITextFieldDelegate

extension AddPlantController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
