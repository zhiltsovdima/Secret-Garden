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
}

// MARK: - PlantOptionsViewModel

final class PlantOptionsViewModel {
    
    let tableData = [
        Resources.Strings.Options.edit,
        Resources.Strings.Options.delete
    ]
    
    private weak var output: PlantOptionsOutput?
    private let garden: Garden
    private let indexPath: IndexPath
            
    init(output: PlantOptionsOutput, _ garden: Garden, _ indexPath: IndexPath) {
        self.output = output
        self.garden = garden
        self.indexPath = indexPath
    }

}

// MARK: - PlantOptionsViewModelProtocol

extension PlantOptionsViewModel: PlantOptionsViewModelProtocol {
    
    func editButtonTapped() {
        output?.showEdit(indexPath)
    }
    
    func deleteButtonTapped() {
        garden.removePlant(at: indexPath.row)
        output?.deletePlant()
    }
}
