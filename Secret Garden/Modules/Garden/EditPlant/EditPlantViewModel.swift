//
//  EditPlantViewModel.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 11.01.2023.
//

import Foundation
import UIKit.UIImage

struct PlantModel {
    var plantImage: UIImage?
    var plantTitle: String
}

// MARK: - EditPlantViewModelProtocol

protocol EditPlantViewModelProtocol: AnyObject {
    var viewData: PlantModel! { get }
    var validateCompletion: ((String?) -> Void)? { get set }
    func saveButtonTapped(name: String?, image: UIImage?)
    func viewWillDisappear()
}

// MARK: - EditPlantViewModel

final class EditPlantViewModel {
    
    var viewData: PlantModel!
    
    private weak var output: EditPlantOutput?
    private let garden: Garden
    private let indexPath: IndexPath
    
    var validateCompletion: ((String?) -> Void)?

            
    init(output: EditPlantOutput, _ garden: Garden, _ indexPath: IndexPath) {
        self.output = output
        self.garden = garden
        self.indexPath = indexPath
        self.getViewData()
    }
    
    private func getViewData() {
        let plant = garden.getAllPlants()[indexPath.row]
        viewData = PlantModel(plantImage: plant.imageData.image, plantTitle: plant.name)
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
    
    func saveButtonTapped(name: String?, image: UIImage?) {
        do {
            try validateNewPlant(name: name, image: image)
            garden.updatePlant(name: name, image: image, indexPath.row)
            output?.succesEditing()
        } catch {
            let validateError = error as? ValidateError
            validateCompletion?(validateError?.rawValue)
        }
    }
    
    func viewWillDisappear() {
        output?.editPlantFinish()
    }
}
