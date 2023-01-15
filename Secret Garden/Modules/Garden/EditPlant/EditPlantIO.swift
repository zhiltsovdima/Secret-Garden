//
//  EditPlantIO.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 11.01.2023.
//

import UIKit.UIImage

// MARK: - EditPlantOutput

protocol EditPlantOutput: AnyObject {
    func succesEditing()
    func editPlantFinish()
    func showAddNewPhotoAlert(completion: @escaping (UIImage) -> Void)
}
