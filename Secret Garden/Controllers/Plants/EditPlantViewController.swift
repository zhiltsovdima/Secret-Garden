//
//  EditPlantViewController.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 06.11.2022.
//

import UIKit

final class EditPlantViewController: DetailBaseController {
    
    private let plantToEdit: Plant
        
    private let nameLabel = UILabel()
    private let notValidParameters = UILabel()
    
    private let viewForTextField = UIView()
    private let nameTextField = UITextField()
     
    private let imageLabel = UILabel()
    private let chooseImageButton = UIButton()
    private let saveButton = BaseButton()
    private let actualIndexPath: IndexPath

    var saveEditedPlantHandler: ((Plant, IndexPath)-> Void)?
    
    init(_ plantToEdit: Plant, _ actualIndexPath: IndexPath) {
        self.plantToEdit = plantToEdit
        self.actualIndexPath = actualIndexPath
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setupViews()
        setConstraints()
        setDelegate()

    }
    
    private func setDelegate() {
        nameTextField.delegate = self
    }
    
    override func setupViews() {
        super.setupViews()
        
        plantImageView.image = plantToEdit.image.getImage()
        
        detailInfoView.addSubview(viewForTextField)
        viewForTextField.backgroundColor = Resources.Colors.backgroundFields
        viewForTextField.layer.borderColor = UIColor.lightGray.cgColor
        viewForTextField.layer.borderWidth = 0.5
        viewForTextField.layer.cornerRadius = 5
        
        detailInfoView.addSubview(nameTextField)
        nameTextField.backgroundColor = Resources.Colors.backgroundFields
        nameTextField.text = plantToEdit.name
        nameTextField.font = Resources.Fonts.general
        
        detailInfoView.addSubview(nameLabel)
        nameLabel.text = Resources.Strings.Common.name
        nameLabel.font = Resources.Fonts.generalBold
        
        detailInfoView.addSubview(notValidParameters)
        notValidParameters.font = Resources.Fonts.general?.withSize(12)
        notValidParameters.numberOfLines = 0
        notValidParameters.textColor = .red
        notValidParameters.isHidden = true
        
        detailInfoView.addSubview(imageLabel)
        imageLabel.text = "Image"
        imageLabel.font = Resources.Fonts.generalBold
        
        detailInfoView.addSubview(chooseImageButton)
        chooseImageButton.backgroundColor = Resources.Colors.backgroundFields
        chooseImageButton.layer.cornerRadius = 5
        chooseImageButton.layer.borderColor = UIColor.lightGray.cgColor
        chooseImageButton.layer.borderWidth = 0.5
        chooseImageButton.setTitleColor(.black, for: .normal)
        chooseImageButton.titleLabel?.font = Resources.Fonts.general?.withSize(12)
        chooseImageButton.setTitle("Choose new", for: .normal)
        chooseImageButton.addTarget(self, action: #selector(choosePhotoAlert), for: .touchUpInside)
        
        detailInfoView.addSubview(saveButton)
        saveButton.setTitle(Resources.Strings.Common.save, for: .normal)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        notValidParameters.translatesAutoresizingMaskIntoConstraints = false
        viewForTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        imageLabel.translatesAutoresizingMaskIntoConstraints = false
        chooseImageButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: detailInfoView.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: detailInfoView.leadingAnchor, constant: 20),
            
            notValidParameters.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 10),
            notValidParameters.bottomAnchor.constraint(equalTo: viewForTextField.topAnchor, constant: -5),
            notValidParameters.trailingAnchor.constraint(equalTo: detailInfoView.trailingAnchor, constant: -20),

            viewForTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            viewForTextField.leadingAnchor.constraint(equalTo: detailInfoView.leadingAnchor, constant: 20),
            viewForTextField.trailingAnchor.constraint(equalTo: detailInfoView.trailingAnchor, constant: -20),
            viewForTextField.heightAnchor.constraint(equalToConstant: 40),
 
            nameTextField.topAnchor.constraint(equalTo: viewForTextField.topAnchor, constant: 5),
            nameTextField.leadingAnchor.constraint(equalTo: viewForTextField.leadingAnchor, constant: 5),
            nameTextField.trailingAnchor.constraint(equalTo: viewForTextField.trailingAnchor, constant: -5),
            nameTextField.heightAnchor.constraint(equalToConstant: 30),

            imageLabel.topAnchor.constraint(equalTo: viewForTextField.bottomAnchor, constant: 10),
            imageLabel.leadingAnchor.constraint(equalTo: detailInfoView.leadingAnchor, constant: 20),

            chooseImageButton.topAnchor.constraint(equalTo: imageLabel.bottomAnchor, constant: 5),
            chooseImageButton.leadingAnchor.constraint(equalTo: detailInfoView.leadingAnchor, constant: 20),
            chooseImageButton.widthAnchor.constraint(equalToConstant: 100),
            chooseImageButton.heightAnchor.constraint(equalToConstant: 30),
    
            saveButton.centerXAnchor.constraint(equalTo: detailInfoView.centerXAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: 50),
            saveButton.widthAnchor.constraint(equalToConstant: 150),
            saveButton.topAnchor.constraint(equalTo: chooseImageButton.bottomAnchor, constant: 20)
        ])
    }
    
    @objc private func saveButtonTapped() {
        guard nameTextField.hasText else {
            notValidParameters.text = Resources.Strings.AddPlant.emptyName
            notValidParameters.isHidden = false
            return
        }
        let newImage = PlantImage(plantImageView.image!)
        let newName = nameTextField.text!
        let editedPlant = Plant(name: newName, image: newImage)
        
        saveEditedPlantHandler?(editedPlant, actualIndexPath)
        dismiss(animated: true)
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
        if textField.hasText {
            textField.resignFirstResponder()
            notValidParameters.isHidden = true
            return true
        } else {
            notValidParameters.text = Resources.Strings.AddPlant.emptyName
            notValidParameters.isHidden = false
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


