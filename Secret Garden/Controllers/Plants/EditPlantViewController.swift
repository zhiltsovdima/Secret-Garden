//
//  EditPlantViewController.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 06.11.2022.
//

import UIKit

final class EditPlantViewController: DetailBaseController {
    
    let nameTextField = UITextField()
    
    let nameLabel = UILabel()
    let nameView = UIView()
    
    let imageLabel = UILabel()
    let chooseImageButton = UIButton()
    let saveButton = BaseButton()
         
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        configureTextField()

    }
    
    override func setupViews() {
        
        detailInfoView.addSubview(nameView)
        nameView.backgroundColor = Resources.Colors.backgroundFields
        nameView.layer.borderColor = UIColor.lightGray.cgColor
        nameView.layer.borderWidth = 0.5
        nameView.layer.cornerRadius = 5
        
        detailInfoView.addSubview(nameTextField)
        nameTextField.backgroundColor = Resources.Colors.backgroundFields
        
        detailInfoView.addSubview(nameLabel)
        nameLabel.text = Resources.Strings.Common.name
        
        detailInfoView.addSubview(imageLabel)
        imageLabel.text = "Image"
        
        detailInfoView.addSubview(chooseImageButton)
        chooseImageButton.backgroundColor = Resources.Colors.backgroundFields
        chooseImageButton.layer.cornerRadius = 5
        chooseImageButton.layer.borderColor = UIColor.lightGray.cgColor
        chooseImageButton.layer.borderWidth = 0.5
        chooseImageButton.setTitleColor(.black, for: .normal)
        chooseImageButton.titleLabel?.font = UIFont(name: "Helvetica", size: 12)
        chooseImageButton.setTitle("Choose new", for: .normal)
        chooseImageButton.addTarget(self, action: #selector(choosePhotoAlert), for: .touchUpInside)
        
        detailInfoView.addSubview(saveButton)
        saveButton.setTitle(Resources.Strings.Common.save, for: .normal)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    override func setConstraints() {
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: detailInfoView.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: detailInfoView.leadingAnchor, constant: 20),
            nameLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        nameView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            nameView.leadingAnchor.constraint(equalTo: detailInfoView.leadingAnchor, constant: 20),
            nameView.trailingAnchor.constraint(equalTo: detailInfoView.trailingAnchor, constant: -20),
            nameView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: nameView.topAnchor, constant: 5),
            nameTextField.leadingAnchor.constraint(equalTo: nameView.leadingAnchor, constant: 5),
            nameTextField.trailingAnchor.constraint(equalTo: nameView.trailingAnchor, constant: -5),
            nameTextField.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        imageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageLabel.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 10),
            imageLabel.leadingAnchor.constraint(equalTo: detailInfoView.leadingAnchor, constant: 20),
            imageLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        chooseImageButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            chooseImageButton.topAnchor.constraint(equalTo: imageLabel.bottomAnchor, constant: 5),
            chooseImageButton.leadingAnchor.constraint(equalTo: detailInfoView.leadingAnchor, constant: 20),
            chooseImageButton.widthAnchor.constraint(equalToConstant: 100),
            chooseImageButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            saveButton.centerXAnchor.constraint(equalTo: detailInfoView.centerXAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: 50),
            saveButton.widthAnchor.constraint(equalToConstant: 150),
            saveButton.topAnchor.constraint(equalTo: chooseImageButton.bottomAnchor, constant: 20)
        ])
    }
    
    private func configureTextField() {
        nameTextField.delegate = self
    }
    
    @objc private func saveButtonTapped() {

    }
}

// MARK: - UIImagePickerController
extension EditPlantViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
extension EditPlantViewController {
    
    @objc private func choosePhotoAlert() {
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

// MARK: - UITextFieldDelegate

extension EditPlantViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


