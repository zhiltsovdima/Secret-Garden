//
//  DetailArticleViewModel.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 25.05.2023.
//

import Foundation
import RxSwift
import RxCocoa

protocol DetailArticleViewModelProtocol: AnyObject {
    var article: ArticleViewModelProtocol { get }
    var loadingState: BehaviorRelay<LoadingState> { get }
    func fetchFullText()
}

// MARK: - DetailArticleViewModel

final class DetailArticleViewModel {
    
    let article: ArticleViewModelProtocol
    
    let loadingState = BehaviorRelay<LoadingState>(value: .idle)
        
    private weak var coordinator: HomeCoordinatorProtocol?
    private let newsService: NewsServiceProtocol
    
    init(_ coordinator: HomeCoordinatorProtocol, _ newsService: NewsServiceProtocol,_ article: ArticleViewModelProtocol) {
        self.coordinator = coordinator
        self.newsService = newsService
        self.article = article
    }
}

// MARK: - DetailArticleViewModelProtocol

extension DetailArticleViewModel: DetailArticleViewModelProtocol {
    
    func fetchFullText() {
        guard article.fullText.value == nil else { return }
        loadingState.accept(.loading)
        article.getFullText() { [weak self] result in
            guard let self else { return }
            switch result {
            case .success:
                loadingState.accept(.loaded)
            case .failure(let error as NetworkError):
                loadingState.accept(.failed(error.description))
            case .failure(let error as DataCodingError):
                loadingState.accept(.failed(error.description))
            case .failure(let error):
                loadingState.accept(.failed(error.localizedDescription))
            }
        }
    }
}
