//
//  EditPlantCoordinator.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 13.01.2023.
//

import UIKit.UINavigationController

final class EditPlantCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: PlantOptionsCoordinator?
    
    private let navigationController: UINavigationController
    private let garden: Garden
    private let indexPath: IndexPath
        
    init(_ navigationController: UINavigationController, _ garden: Garden,_ indexPath: IndexPath) {
        self.navigationController = navigationController
        self.garden = garden
        self.indexPath = indexPath
    }
    
    func start() {
        let viewModel = EditPlantViewModel(output: self, garden, indexPath)
        let editView = EditPlantViewController(viewModel: viewModel)
        navigationController.dismiss(animated: true)
        navigationController.present(editView, animated: true)
    }
    
}

extension EditPlantCoordinator: EditPlantOutput {
    
    func succesEditing() {
        navigationController.dismiss(animated: true)
    }
    
    func editPlantFinish() {
        parentCoordinator?.childDidFinish(self)
    }
}
