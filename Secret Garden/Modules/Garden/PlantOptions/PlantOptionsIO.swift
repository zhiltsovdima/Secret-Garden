//
//  PlantOptionsIO.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 11.01.2023.
//

import Foundation

// MARK: - PlantOptionsOutput

protocol PlantOptionsOutput: AnyObject {
    func showEdit(_ indexPath: IndexPath)
    func deletePlant()
    func plantOptionsFinish()
}
