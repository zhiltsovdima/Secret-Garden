//
//  EditPlantViewModel.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 11.01.2023.
//

import Foundation
import UIKit.UIImage

struct PlantModel {
    var id: String
    var plantImage: UIImage?
    var plantTitle: String
}

// MARK: - EditPlantViewModelProtocol

protocol EditPlantViewModelProtocol: AnyObject {
    var viewData: PlantModel! { get }
    var validateCompletion: ((String?) -> Void)? { get set }
    var updateImageCompletion: ((UIImage) -> Void)? { get set }
    func addNewPhotoTapped()
    func saveButtonTapped(name: String?, image: UIImage?)
    func viewWillDisappear()
}

// MARK: - EditPlantViewModel

final class EditPlantViewModel {
    
    var viewData: PlantModel!
    
    private weak var coordinator: EditPlantCoordinatorProtocol?
    private let garden: Garden
    private let index: Int
    
    var validateCompletion: ((String?) -> Void)?
    var updateImageCompletion: ((UIImage) -> Void)?
            
    init(coordinator: EditPlantCoordinatorProtocol, _ garden: Garden, index: Int) {
        self.coordinator = coordinator
        self.garden = garden
        self.index = index
        self.getViewData()
    }
    
    private func getViewData() {
        let plant = garden.plants[index]
        viewData = PlantModel(id: plant.id, plantImage: plant.imageData.image, plantTitle: plant.name)
    }
    
    private func validateNewPlant(name: String?, image: UIImage?) throws {
        if let name, name.isEmpty {
            throw ValidateError.emptyName
        } else if image == nil {
            throw ValidateError.emptyImage
        }
    }
}

// MARK: - EditPlantViewModelProtocol

extension EditPlantViewModel: EditPlantViewModelProtocol {
    
    func addNewPhotoTapped() {
        coordinator?.showAddNewPhotoAlert { [weak self] image in
            self?.updateImageCompletion?(image)
        }
    }
    
    func saveButtonTapped(name: String?, image: UIImage?) {
        do {
            try validateNewPlant(name: name, image: image)
            garden.updatePlant(id: viewData.id, name: name!, image: image!, at: index)
            garden.savePlants()
            coordinator?.successEditing()
        } catch {
            let validateError = error as! ValidateError
            validateCompletion?(validateError.description)
        }
    }
    
    func viewWillDisappear() {
        coordinator?.editPlantFinish()
    }
}
