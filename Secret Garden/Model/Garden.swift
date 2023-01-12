//
//  Garden.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 09.11.2022.
//

import UIKit

class Garden {
    var plants = [Plant]()
    
    var updatePlantsCompletion: ((TypeOfChangeModel, Int?) -> Void)?
    
    var isItEmpty: Bool {
        plants.isEmpty
    }
    
    init() {
        loadFromFile()
    }
    
    func getAllPlants() -> [Plant] {
        return plants
    }
    
    private func checkAndCreateDirectory(at url: URL) {
        let isExist = checkExistingOfFile(at: url)
        guard !isExist else { return }
        do {
            try FileManager.default.createDirectory(at: url, withIntermediateDirectories: false)
        } catch {
            print(error)
        }
    }
    
    private func checkExistingOfFile(at url: URL) -> Bool {
        return FileManager.default.fileExists(atPath: url.path)
    }
    
    private func pathForStoringData() -> URL? {
        guard let appSuppDirectory = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else { return nil }
        checkAndCreateDirectory(at: appSuppDirectory)

        let folderForStoring = appSuppDirectory.appendingPathComponent(Resources.Strings.PathForStoringData.folderName)
        checkAndCreateDirectory(at: folderForStoring)
        let pathForStoring = folderForStoring.appendingPathComponent(Resources.Strings.PathForStoringData.fileName)
        
        return pathForStoring
    }
    
    func saveToFile() {
        guard let path = pathForStoringData() else { return }
        let jsonData = try? JSONEncoder().encode(plants)
        if let jsonData {
            do {
                try jsonData.write(to: path)
            } catch {
                print(error)
            }
        }
    }
    
    func loadFromFile() {
        guard let path = pathForStoringData() else { return }
        guard checkExistingOfFile(at: path) else { return }
        do {
            let jsonData = try Data(contentsOf: path)
            plants = try JSONDecoder().decode([Plant].self, from: jsonData)
        } catch {
            let netError = NetworkError.handleError(error)
            print(netError.rawValue)
        }
    }
    
    func updatePlant(name: String?, image: UIImage?, _ rowInt: Int) {
        plants[rowInt].name = name!
        plants[rowInt].imageData = PlantImageData(image!)
        plants[rowInt].isFetched = false
        updatePlantsCompletion?(.update, rowInt)
    }
    
    func addNewPlant(name: String, image: UIImage) {
        let imageData = PlantImageData(image)
        let plant = Plant(name: name, image: imageData)
        plants.insert(plant, at: 0)
        updatePlantsCompletion?(.insert, nil)
    }
    
    func addNewPlant(_ newPlant: Plant) {
        plants.insert(newPlant, at: 0)
        updatePlantsCompletion?(.insert, nil)
    }
    
    func removePlant(at index: Int) {
        plants.remove(at: index)
        updatePlantsCompletion?(.delete, index)
    }
}
