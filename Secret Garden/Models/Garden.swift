//
//  Garden.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 09.11.2022.
//

import UIKit

class Garden {
    private(set) var plants = [Plant]()
    private let networkManager: NetworkManagerProtocol
    
    var updatePlantsCompletion: ((TypeOfChangeModel, Int?) -> Void)?
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func updatePlant(name: String, image: UIImage, at index: Int) {
        plants[index].name = name
        plants[index].imageData = PlantImageData(image)
        plants[index].isFetched = false
        updatePlantsCompletion?(.update, index)
    }
    
    func addNewPlant(name: String, image: UIImage) {
        let imageData = PlantImageData(image)
        let plant = Plant(name: name, image: imageData)
        plants.insert(plant, at: 0)
        updatePlantsCompletion?(.insert, nil)
    }
    
    func removePlant(at index: Int) {
        plants.remove(at: index)
        updatePlantsCompletion?(.delete, index)
    }
    
    func downloadFeatures(for plant: Plant, completion: ((Features?, NetworkError?) -> Void)?) {
        if let features = plant.features {
            completion?(features, nil)
            return
        }
        
        guard !plant.isFetched else { completion?(nil, NetworkError.noDataForThisName); return }
        networkManager.getPlant(by: plant.name) { [weak plant] result in
            switch result {
            case .success(let features):
                plant?.features = features
                plant?.isFetched = true
                completion?(plant?.features, nil)
            case .failure(let error):
                plant?.isFetched = true
                completion?(nil, error)
            }
        }
    }
}

// MARK: - Save & Load to file

extension Garden {
    
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
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .binary
        do {
            let data = try encoder.encode(plants)
            try data.write(to: path)
        } catch {
            print("Error")
        }
    }
    
    func loadFromFile() {
        guard let path = pathForStoringData() else { return }
        guard checkExistingOfFile(at: path) else { return }
        let decoder = PropertyListDecoder()
        do {
            let data = try Data(contentsOf: path)
            plants = try decoder.decode([Plant].self, from: data)
        } catch {
            let netError = NetworkError.handleError(error)
            print(netError.description)
        }
    }
}
