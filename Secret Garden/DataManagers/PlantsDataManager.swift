//
//  PlantsDataManager.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 19.02.2023.
//

import Foundation

protocol PlantsDataManagerProtocol {
    func loadFromFile() -> Result<[Plant], Error>
    func saveToFile(plants: [Plant])
}

final class PlantsDataManager: PlantsDataManagerProtocol {
    
    private func checkAndCreateDirectory(at url: URL) {
        let isExist = checkExistingOfFile(at: url)
        guard !isExist else { return }
        do {
            try FileManager.default.createDirectory(at: url, withIntermediateDirectories: false)
        } catch {
            print("Failed to create a directory: \(error)")
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
    
    func loadFromFile() -> Result<[Plant], Error> {
        guard let path = pathForStoringData() else { return .failure(FileManagerError.invalidPath)}
        guard checkExistingOfFile(at: path) else { return .failure(FileManagerError.fileNotFound)}
        let decoder = PropertyListDecoder()
        do {
            let data = try Data(contentsOf: path)
            let plants = try decoder.decode([Plant].self, from: data)
            return .success(plants)
        } catch {
            return .failure(error)
        }
    }
    
    func saveToFile(plants: [Plant]) {
        guard let path = pathForStoringData() else { return }
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .binary
        do {
            let data = try encoder.encode(plants)
            try data.write(to: path)
        } catch {
            print("Failed saveToFile: \(error)")
        }
    }
}
