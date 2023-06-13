//
//  NewsService.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 09.06.2023.
//

import UIKit

protocol NewsServiceProtocol {
    func getNews(completion: @escaping (Result<[ArticleData], Error>) -> Void)
    func getBody(for article: ArticleViewModelProtocol, completion: @escaping (Result<ArticleTextData, Error>) -> Void)
    func getImage(for article: ArticleViewModelProtocol, completion: @escaping ((Result<UIImage, Error>) -> Void))
}

final class NewsService {
    
    private let networkManager: NetworkManagerProtocol
    
    private var imageCache = NSCache<NSURL, UIImage>()
    
    init(_ networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
}

// MARK: - NewsServiceeProtocol

extension NewsService: NewsServiceProtocol {
    
    func getNews(completion: @escaping (Result<[ArticleData], Error>) -> Void) {
        fetchData(apiEndpoint: .news, completion: completion)
    }
    
    func getBody(for article: ArticleViewModelProtocol, completion: @escaping (Result<ArticleTextData, Error>) -> Void) {
        fetchData(apiEndpoint: .fullText(article.textId), completion: completion)
    }
    
    func getImage(for article: ArticleViewModelProtocol, completion: @escaping ((Result<UIImage, Error>) -> Void)) {
        guard let imageURL = URL(string: article.imageString) else {
            completion(.failure(NetworkError.wrongURL))
            return
        }
        if let cachedImage = imageCache.object(forKey: imageURL as NSURL) {
            completion(.success(cachedImage))
            return
        }
        networkManager.fetchData(url: imageURL) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                processImageData(data, imageURL: imageURL, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

// MARK: - Private Methods

extension NewsService {
    
    private func fetchData<T: Decodable>(apiEndpoint: APIEndpoints, completion: @escaping (Result<T, Error>) -> Void) {
        networkManager.fetchData(apiEndpoint: apiEndpoint) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                parseData(data, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func parseData<T: Decodable>(_ data: Data, completion: @escaping (Result<T, Error>) -> Void) {
        let parseResult = DataCoder.decode(type: T.self, from: data)
        switch parseResult {
        case .success(let weatherData):
            completion(.success(weatherData))
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
    private func processImageData(_ data: Data, imageURL: URL, completion: @escaping ((Result<UIImage, Error>) -> Void)) {
        guard let image = UIImage(data: data) else {
            completion(.failure(DataCodingError.decodingToImageFailed))
            return
        }
        imageCache.setObject(image, forKey: imageURL as NSURL)
        completion(.success(image))
    }
}
