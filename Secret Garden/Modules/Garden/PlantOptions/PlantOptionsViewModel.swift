//
//  PlantOptionsViewModel.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 11.01.2023.
//

import Foundation

// MARK: - PlantOptionsViewModelProtocol

protocol PlantOptionsViewModelProtocol: AnyObject {
    var tableData: [String] { get }
    func editButtonTapped()
    func deleteButtonTapped()
    func viewWillDisappear()
}

// MARK: - PlantOptionsViewModel

final class PlantOptionsViewModel {
    
    let tableData = [
        Resources.Strings.Options.edit,
        Resources.Strings.Options.delete
    ]
    
    private weak var coordinator: PlantOptionsCoordinatorProtocol?
    private let garden: Garden
    private let indexPath: IndexPath
    private let id: String
            
    init(coordinator: PlantOptionsCoordinatorProtocol, _ garden: Garden, _ indexPath: IndexPath, id: String) {
        self.coordinator = coordinator
        self.garden = garden
        self.indexPath = indexPath
        self.id = id
    }

}

// MARK: - PlantOptionsViewModelProtocol

extension PlantOptionsViewModel: PlantOptionsViewModelProtocol {
    
    func editButtonTapped() {
        coordinator?.showEdit(indexPath)
    }
    
    func deleteButtonTapped() {
        garden.removePlant(id: id, at: indexPath.row)
        garden.savePlants()
        coordinator?.successDeleting()
    }
    
    func viewWillDisappear() {
        coordinator?.plantOptionsFinish()
    }
}
