//
//  GardenViewModel.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 09.01.2023.
//

import Foundation

enum TypeOfChangeModel {
    case update
    case insert
    case delete
}

// MARK: - GardenViewModelProtocol

protocol GardenViewModelProtocol: AnyObject {
    
    var tableData: [PlantCellModel] { get }
    
    var updateTabelData: ((Int?) -> Void)? { get set }
    var insertTabelData: (() -> Void)? { get set }
    var deleteTabelData: ((Int) -> Void)? { get set }
    
    func addNewPlantTapped()
    func rowTapped(_ rowInt: Int)
    func settingsTapped(_ cell: PlantCell)

}

// MARK: - GardenViewModel

final class GardenViewModel {

    private weak var output: GardenOutput?
    private let garden: Garden
    var tableData = [PlantCellModel]()
    
    var updateTabelData: ((Int?) -> Void)?
    var insertTabelData: (() -> Void)?
    var deleteTabelData: ((Int) -> Void)?
    
    init(output: GardenOutput, garden: Garden) {
        self.output = output
        self.garden = garden
        self.updateModel()
        self.setUpdate()
    }
}

// MARK: - GardenViewModelProtocol

extension GardenViewModel: GardenViewModelProtocol {
    
    private func setUpdate() {
        garden.updatePlantsCompletion = { [weak self] typeOfChange, rowInt in
            self?.updateViewUserData(typeOfChange, rowInt)
        }
    }
    
    private func updateViewUserData(_ typeOfChange: TypeOfChangeModel, _ rowInt: Int?) {
        DispatchQueue.main.async {
            self.updateModel()
            switch typeOfChange {
            case .update:
                self.updateTabelData?(rowInt)
            case .insert:
                self.insertTabelData?()
            case .delete:
                self.deleteTabelData?(rowInt!)
            }
        }
    }
    
    func updateModel() {
        let plants = garden.getAllPlants()
        tableData = plants.compactMap { PlantCellModel(plantImage: $0.imageData.image, plantTitle: $0.name) }
    }
    
    func addNewPlantTapped() {
        output?.showAddNewPlant()
    }
    
    func rowTapped(_ rowInt: Int) {
        output?.showPlantDetail(rowInt)
    }
    
    func settingsTapped(_ cell: PlantCell) {
        output?.showOptions(cell)
    }


}
