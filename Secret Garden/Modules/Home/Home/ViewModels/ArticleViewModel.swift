//
//  ArticleModel.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 26.05.2023.
//

import Foundation
import RxSwift
import RxCocoa

protocol ArticleViewModelProtocol: AnyObject {
    var title: String { get }
    var category: String { get }
    var textId: String { get }
    var imageString: String { get }
    var date: String { get }
    
    var image: BehaviorRelay<UIImage?> { get }
    var fullText: BehaviorRelay<String?> { get }
    
    func getImage()
    func getFullText(completion: @escaping (Result<String,Error>) -> Void)
}

final class ArticleViewModel {
    
    private let newsService: NewsServiceProtocol
    
    let title: String
    let category: String
    let textId: String
    let imageString: String
    let date: String
    
    var image = BehaviorRelay<UIImage?>(value: nil)
    var fullText = BehaviorRelay<String?>(value: nil)
    
    private var isLoaded = false
    
    init(_ newsService: NewsServiceProtocol, title: String, category: String, textId: String, imageString: String, date: String) {
        self.newsService = newsService
        self.title = title
        self.category = category
        self.textId = textId
        self.imageString = imageString
        self.date = date
    }
}

extension ArticleViewModel: ArticleViewModelProtocol {
    
    func getImage() {
        guard !isLoaded else { return }
        newsService.getImage(for: self) { [weak self] result in
            guard let self else { return }
            switch result {
            case.success(let fetchedImage):
                image.accept(fetchedImage)
                isLoaded = true
            case .failure(let error):
                handleError(error)
                isLoaded = false
            }
        }
    }
    
    func getFullText(completion: @escaping (Result<String,Error>) -> Void) {
        guard fullText.value == nil else { return }
        newsService.getBody(for: self) { [weak self] result in
            guard let self else { return }
            switch result {
            case.success(let articleTextData):
                let text = articleTextData.body
                fullText.accept(text)
                isLoaded = true
                completion(.success(text))
            case .failure(let error):
                handleError(error)
                isLoaded = false
                completion(.failure(error))
            }
        }
    }
}

// MARK: - Private Methods

extension ArticleViewModel {
    
    private func handleError(_ error: Error) {
        switch error {
        case let networkError as NetworkError:
            print(networkError.description)
        case let codingError as DataCodingError:
            print(codingError.description)
        default:
            print(error.localizedDescription)
        }
    }
}
