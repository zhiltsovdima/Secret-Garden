//
//  AddPlantViewModel.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 10.01.2023.
//

import UIKit.UIImage

// MARK: - AddPlantViewModelProtocol

protocol AddPlantViewModelProtocol: AnyObject {
    var validateCompletion: ((String?) -> Void)? { get set }
    var updateImageCompletion: ((UIImage) -> Void)? { get set }
    func addNewPhotoTapped()
    func saveButtonTapped(name: String?, image: UIImage?)
    func viewWillDisappear()
}

// MARK: - AddPlantViewModel

final class AddPlantViewModel {
    
    private weak var coordinator: AddNewPlantCoordinatorProtocol?

    private let garden: Garden
    
    var validateCompletion: ((String?) -> Void)?
    var updateImageCompletion: ((UIImage) -> Void)?
            
    init(coordinator: AddNewPlantCoordinatorProtocol, garden: Garden) {
        self.coordinator = coordinator
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
    
    func addNewPhotoTapped() {
        coordinator?.showAddNewPhotoAlert { [weak self] image in
            self?.updateImageCompletion?(image)
        }
    }
    
    func saveButtonTapped(name: String?, image: UIImage?) {
        do {
            try validateNewPlant(name: name, image: image)
            garden.addNewPlant(name: name!, image: image!)
            garden.savePlants()
            coordinator?.succesAdding()
        } catch {
            let validateError = error as! ValidateError
            validateCompletion?(validateError.description)
        }
    }
    
    func viewWillDisappear() {
        coordinator?.addPlantFinish()
    }

}
