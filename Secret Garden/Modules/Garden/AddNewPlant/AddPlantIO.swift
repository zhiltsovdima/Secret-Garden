//
//  AddPlantIO.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 10.01.2023.
//

import UIKit.UIImage

// MARK: - PlantsOutput

protocol AddPlantOutput: AnyObject {
    func succesAdding()
    func addPlantFinish()
    func showAddNewPhotoAlert(completion: @escaping (UIImage) -> Void)
}

