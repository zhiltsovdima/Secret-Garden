//
//  Garden.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 09.11.2022.
//

import UIKit

class Garden {
    var plants = [Plant]() {
        didSet {
            saveToFile()
            print("save to file")
        }
    }
    
    init() {
        loadFromFile()
    }
    
    var archiveURL: URL {
        return getArchiveURL()
    }
    
    func getArchiveURL() -> URL {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let documentFolder = documentDirectory.appendingPathComponent(Resources.Strings.FolderForSaveData.garden)
        do {
            try FileManager.default.createDirectory(at: documentFolder, withIntermediateDirectories: true)
        } catch {
            print("Error: \(error)")
        }
        let archiveURL = documentFolder.appendingPathComponent(Resources.Strings.FolderForSaveData.garden)
        //print("Archive URL: \(archiveURL)")
        return archiveURL
    }
    
    func saveToFile() {
        
        let jsonData = try? JSONEncoder().encode(plants)
        
        if let jsonData {
            let pathToSave = archiveURL
            do {
                try jsonData.write(to: pathToSave)
            } catch {
                print(error)
            }
        }
    }
    
    func loadFromFile() {
        guard FileManager.default.fileExists(atPath: archiveURL.path) else { return }
        print("load from file")

        do {
            let jsonData = try Data(contentsOf: archiveURL)
            plants = try JSONDecoder().decode([Plant].self, from: jsonData)
        } catch {
            print("Error: \(error)")
        }
    }
    
    func addNewPlant(name: String, image: UIImage) {
        let imageData = PlantImage(image)
        let plant = Plant(name: name, image: imageData)
        plants.insert(plant, at: 0)
    }
    
    func removePlant(at index: Int) {
        plants.remove(at: index)
    }
}