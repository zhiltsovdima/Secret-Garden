//
//  AlertCoordinator.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 15.01.2023.
//

import UIKit

final class AlertCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    
    private var navigationController: UINavigationController
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        switch parentCoordinator {
        case is ImagePickable:
            createPhotoChooseAlert()
        default:
            break
        }
    }
    
    private func createPhotoChooseAlert() {
        guard let parent = parentCoordinator as? (ImagePickable & Coordinator) else { return }
        let alertController = UIAlertController(title: Resources.Strings.AddPlant.titleAlert, message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: Resources.Strings.AddPlant.camera, style: .default) { _ in
            parent.showImagePicker(sourceType: .camera)
            parent.childDidFinish(self)
        }
        let photoLibraryAction = UIAlertAction(title: Resources.Strings.AddPlant.photoLibrary, style: .default) { _ in
            parent.showImagePicker(sourceType: .photoLibrary)
            parent.childDidFinish(self)
        }
        let cancelAction = UIAlertAction(title: Resources.Strings.Common.cancel, style: .cancel) { _ in
            parent.childDidFinish(self)
        }
        
        alertController.addAction(cameraAction)
        alertController.addAction(photoLibraryAction)
        alertController.addAction(cancelAction)
        navigationController.visibleViewController?.present(alertController, animated: true)
    }
}
