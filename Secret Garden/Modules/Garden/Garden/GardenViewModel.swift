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
    var isEmptyTableData: Bool { get }
    
    var updateTabelData: ((Int?) -> Void)? { get set }
    var insertTabelData: (() -> Void)? { get set }
    var deleteTabelData: ((Int) -> Void)? { get set }
    
    func addNewPlantTapped()
    func tableRowTapped(_ indexPath: IndexPath)
    func settingsTapped(_ cell: PlantCell, id: String)
}

// MARK: - GardenViewModel

final class GardenViewModel {
    
    private(set) var tableData = [PlantCellModel]() {
        didSet {
            isEmptyTableData = tableData.isEmpty
        }
    }
    var isEmptyTableData = true

    private weak var coordinator: GardenCoordinatorProtocol?
    private let garden: Garden

    var updateTabelData: ((Int?) -> Void)?
    var insertTabelData: (() -> Void)?
    var deleteTabelData: ((Int) -> Void)?
    
    init(coordinator: GardenCoordinatorProtocol, garden: Garden) {
        self.coordinator = coordinator
        self.garden = garden
        self.updateModel()
        self.setUpdate()
    }
}

// MARK: - GardenViewModelProtocol

extension GardenViewModel: GardenViewModelProtocol {
    
    private func setUpdate() {
        garden.updatePlantsCompletion = { [weak self] typeOfChange, index in
            self?.updateViewUserData(typeOfChange, index)
        }
    }
    
    private func updateViewUserData(_ typeOfChange: TypeOfChangeModel, _ index: Int?) {
        DispatchQueue.main.async {
            self.updateModel()
            switch typeOfChange {
            case .update:
                self.updateTabelData?(index)
            case .insert:
                self.insertTabelData?()
            case .delete:
                guard let index else { return }
                self.deleteTabelData?(index)
            }
        }
    }
    
    private func updateModel() {
        garden.loadFromFile()
        tableData = garden.plants.compactMap { PlantCellModel(id: $0.id, plantImage: $0.imageData.image, plantTitle: $0.name) }
    }
    
    func addNewPlantTapped() {
        coordinator?.showAddNewPlant()
    }
    
    func tableRowTapped(_ indexPath: IndexPath) {
        let id = tableData[indexPath.row].id
        guard let plant = garden.plants.first(where: { $0.id == id }) else { return }
        coordinator?.showPlantDetail(plant)
    }
    
    func settingsTapped(_ cell: PlantCell, id: String) {
        coordinator?.showOptions(cell, id: id)
    }
}
