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
            
    init(coordinator: PlantOptionsCoordinatorProtocol, _ garden: Garden, _ indexPath: IndexPath) {
        self.coordinator = coordinator
        self.garden = garden
        self.indexPath = indexPath
    }

}

// MARK: - PlantOptionsViewModelProtocol

extension PlantOptionsViewModel: PlantOptionsViewModelProtocol {
    
    func editButtonTapped() {
        coordinator?.showEdit(indexPath)
    }
    
    func deleteButtonTapped() {
        garden.removePlant(at: indexPath.row)
        garden.saveToFile()
        coordinator?.succesDeleting()
    }
    
    func viewWillDisappear() {
        coordinator?.plantOptionsFinish()
    }
}
