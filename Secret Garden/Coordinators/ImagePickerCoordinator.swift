//
//  ImagePickerCoordinator.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 15.01.2023.
//

import UIKit

final class ImagePickerCoordinator: NSObject, Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: (Coordinator & ImagePickable)?
    var sourceType: UIImagePickerController.SourceType
    
    private let navigationController: UINavigationController
    
    init(_ navigationController: UINavigationController, sourceType: UIImagePickerController.SourceType) {
        self.navigationController = navigationController
        self.sourceType = sourceType
    }
    
    func start() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = sourceType
        navigationController.visibleViewController?.present(imagePickerController, animated: true)
    }
    
}

extension ImagePickerCoordinator: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage, let parentCoordinator {
            parentCoordinator.didFinishPicking(image)
        }
        navigationController.dismiss(animated: true)
        parentCoordinator?.childDidFinish(self)
    }
}
