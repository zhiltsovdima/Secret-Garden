//
//  AddNewPlantCoordinator.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 13.01.2023.
//

import UIKit.UINavigationController

protocol AddNewPlantCoordinatorProtocol: AnyObject {
    func succesAdding()
    func addPlantFinish()
    func showAddNewPhotoAlert(completion: @escaping (UIImage) -> Void)
}

final class AddNewPlantCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    private var completion: ((UIImage) -> Void)?
    
    private let navigationController: UINavigationController
    private let garden: Garden
        
    init(_ navigationController: UINavigationController, _ garden: Garden) {
        self.navigationController = navigationController
        self.garden = garden
    }
    
    func start() {
        let viewModel = AddPlantViewModel(coordinator: self, garden: garden)
        let addNewPlantView = AddPlantController(viewModel: viewModel)
        navigationController.pushViewController(addNewPlantView, animated: true)
    }
}

// MARK: - ImagePickableProtocol

extension AddNewPlantCoordinator: ImagePickable {
    
    func showImagePicker(sourceType: UIImagePickerController.SourceType) {
        let imagePickerCoordinator = ImagePickerCoordinator(navigationController, sourceType: sourceType)
        imagePickerCoordinator.parentCoordinator = self
        imagePickerCoordinator.start()
        childCoordinators.append(imagePickerCoordinator)
    }
    
    func didFinishPicking(_ image: UIImage) {
        completion?(image)
    }
}

// MARK: - AddNewPlantCoordinatorProtocol

extension AddNewPlantCoordinator: AddNewPlantCoordinatorProtocol {
    
    func showAddNewPhotoAlert(completion: @escaping (UIImage) -> Void) {
        self.completion = completion
        let choosePhotoAlertCoordinator = AlertCoordinator(navigationController)
        choosePhotoAlertCoordinator.parentCoordinator = self
        choosePhotoAlertCoordinator.start()
        childCoordinators.append(choosePhotoAlertCoordinator)
    }
    
    func succesAdding() {
        navigationController.popViewController(animated: true)
    }
    
    func addPlantFinish() {
        parentCoordinator?.childDidFinish(self)
    }

}
