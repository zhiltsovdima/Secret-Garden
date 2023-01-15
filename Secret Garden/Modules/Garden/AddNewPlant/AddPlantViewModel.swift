//
//  AddPlantViewModel.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 10.01.2023.
//

import UIKit.UIImage

enum ValidateError: String, Error {
    case empty = "Please, add the data"
    case emptyName = "You have to add the plant name"
    case emptyImage = "You have to add the Image"
}

// MARK: - AddPlantViewModelProtocol

protocol AddPlantViewModelProtocol: AnyObject {
    var validateCompletion: ((String?) -> Void)? { get set }
    var updateImageCompletion: ((UIImage) -> Void)? { get set }
    func saveButtonTapped(name: String?, image: UIImage?)
    func viewWillDisappear()
    func addNewPhotoTapped()
}

// MARK: - AddPlantViewModel

final class AddPlantViewModel {
    
    private weak var output: AddPlantOutput?

    private let garden: Garden
    
    var validateCompletion: ((String?) -> Void)?
    var updateImageCompletion: ((UIImage) -> Void)?
            
    init(output: AddPlantOutput, garden: Garden) {
        self.output = output
        self.garden = garden
    }

    private func validateNewPlant(name: String?, image: UIImage?) throws {
        if name == nil && image == Resources.Images.Common.camera {
            throw ValidateError.empty
        } else if image == Resources.Images.Common.camera {
            throw ValidateError.emptyImage
        } else if let name, name.isEmpty {
            throw ValidateError.emptyName
        }
    }
}

// MARK: - AddPlantViewModelProtocol

extension AddPlantViewModel: AddPlantViewModelProtocol {
    
    func saveButtonTapped(name: String?, image: UIImage?) {
        do {
            try validateNewPlant(name: name, image: image)
            garden.addNewPlant(name: name!, image: image!)
            output?.succesAdding()
        } catch {
            let validateError = error as? ValidateError
            validateCompletion?(validateError?.rawValue)
        }
    }
    
    func viewWillDisappear() {
        output?.addPlantFinish()
    }
    
    func addNewPhotoTapped() {
        output?.showAddNewPhotoAlert { [weak self] image in
            self?.updateImageCompletion?(image)
        }
    }
}
