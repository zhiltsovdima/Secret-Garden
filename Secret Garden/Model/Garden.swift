//
//  Garden.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 09.11.2022.
//

import UIKit

class Garden {
    var plants = [Plant]()
    
    var isItEmpty: Bool {
        plants.isEmpty
    }
    
    init() {
        loadFromFile()
    }
    
    func checkAndCreateDirectory(at url: URL) {
        let isExist = checkExistingOfFile(at: url)
        guard !isExist else { return }
        do {
            try FileManager.default.createDirectory(at: url, withIntermediateDirectories: false)
        } catch {
            print(error)
        }
    }
    
    func checkExistingOfFile(at url: URL) -> Bool {
        return FileManager.default.fileExists(atPath: url.path)
    }
    
    func pathForStoringData() -> URL? {
        guard let appSuppDirectory = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else { return nil }
        checkAndCreateDirectory(at: appSuppDirectory)

        let folderForStoring = appSuppDirectory.appendingPathComponent(Resources.Strings.pathForStoringData.folderName)
        checkAndCreateDirectory(at: folderForStoring)
        let pathForStoring = folderForStoring.appendingPathComponent(Resources.Strings.pathForStoringData.fileName)
        
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
            print("Error: \(error)")
        }
    }
    
    func addNewPlant(name: String, image: UIImage) {
        let imageData = PlantImageData(image)
        let plant = Plant(name: name, image: imageData)
        plants.insert(plant, at: 0)
    }
    
    func addNewPlant(_ newPlant: Plant) {
        plants.insert(newPlant, at: 0)
    }
    
    func removePlant(at index: Int) {
        plants.remove(at: index)
    }
}
