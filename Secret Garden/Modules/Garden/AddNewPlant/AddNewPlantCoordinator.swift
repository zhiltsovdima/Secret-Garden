//
//  AddNewPlantCoordinator.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 13.01.2023.
//

import UIKit.UINavigationController

final class AddNewPlantCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: GardenCoordinator?
    private var completion: ((UIImage) -> Void)?
    
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
    
    func showImagePicker(sourceType: UIImagePickerController.SourceType) {
        let imagePickerCoordinator = ImagePickerCoordinator(navigationController, sourceType: sourceType)
        imagePickerCoordinator.parentCoordinator = self
        imagePickerCoordinator.start()
        childCoordinators.append(imagePickerCoordinator)
    }
}

extension AddNewPlantCoordinator: AddPlantOutput {
    
    func succesAdding() {
        navigationController.popViewController(animated: true)
    }
    
    func addPlantFinish() {
        parentCoordinator?.childDidFinish(self)
    }
    
    func showAddNewPhotoAlert(completion: @escaping (UIImage) -> Void) {
        self.completion = completion
        let choosePhotoAlertCoordinator = AlertCoordinator(navigationController)
        choosePhotoAlertCoordinator.parentCoordinator = self
        choosePhotoAlertCoordinator.start()
        childCoordinators.append(choosePhotoAlertCoordinator)
    }
    
    func didFinishPicking(_ image: UIImage) {
        completion?(image)
    }

}
