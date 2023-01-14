//
//  DetailPlantCoordinator.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 13.01.2023.
//

import UIKit.UINavigationController

final class DetailPlantCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    var parentCoordinator: GardenCoordinator?
    
    private let navigationController: UINavigationController
    private let garden: Garden
    private let index: Int
        
    init(_ navigationController: UINavigationController, _ garden: Garden, index: Int) {
        self.navigationController = navigationController
        self.garden = garden
        self.index = index
    }
    
    func start() {
        let viewModel = DetailPlantViewModel(output: self, garden, index)
        let detailView = DetailPlantController(viewModel: viewModel)
        navigationController.pushViewController(detailView, animated: true)
    }
}

extension DetailPlantCoordinator: DetailPlantOutput {
    
    func detailPlantFinish() {
        parentCoordinator?.childDidFinish(self)
    }

}
