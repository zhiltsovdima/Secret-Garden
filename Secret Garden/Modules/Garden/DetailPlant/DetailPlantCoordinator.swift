//
//  DetailPlantCoordinator.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 13.01.2023.
//

import UIKit.UINavigationController

protocol DetailPlantCoordinatorProtocol: AnyObject {
    func detailPlantFinish()
}

final class DetailPlantCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    
    private let navigationController: UINavigationController
    private let garden: Garden
    private let plant: Plant
    
    init(_ navigationController: UINavigationController, _ garden: Garden, plant: Plant) {
        self.navigationController = navigationController
        self.garden = garden
        self.plant = plant
    }
    
    func start() {
        let viewModel = DetailPlantViewModel(coordinator: self, garden, plant)
        let detailView = DetailPlantController(viewModel: viewModel)
        navigationController.pushViewController(detailView, animated: true)
    }
}

// MARK: - DetailPlantCoordinatorProtocol

extension DetailPlantCoordinator: DetailPlantCoordinatorProtocol {
    
    func detailPlantFinish() {
        parentCoordinator?.childDidFinish(self)
    }

}
