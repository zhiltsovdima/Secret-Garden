//
//  AddNewPlantCoordinator.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 13.01.2023.
//

import UIKit.UINavigationController

final class AddNewPlantCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    private let garden: Garden
        
    init(_ navigationController: UINavigationController, _ garden: Garden) {
        self.navigationController = navigationController
        self.garden = garden
    }
    
    func start() {
        let viewModel = AddPlantViewModel(output: self, garden: garden)
        let addNewPlantView = AddPlantController(viewModel: viewModel)
        navigationController.pushViewController(addNewPlantView, animated: true)
    }
}

extension AddNewPlantCoordinator: AddPlantOutput {
    
    func succesAdding() {
        navigationController.popViewController(animated: true)
    }
    
    func showChooseImageAlert() {
        
    }

}
