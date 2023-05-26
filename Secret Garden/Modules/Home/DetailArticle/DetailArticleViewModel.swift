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
    var article: ArticleModel { get }
    var loadingState: BehaviorRelay<LoadingState> { get }
    func fetchFullText()
}

// MARK: - DetailArticleViewModel

final class DetailArticleViewModel {
    
    let article: ArticleModel
    
    let loadingState = BehaviorRelay<LoadingState>(value: .idle)
        
    private weak var coordinator: HomeCoordinatorProtocol?
    private let networkManager: NetworkManagerProtocol
    
    init(_ coordinator: HomeCoordinatorProtocol, _ networkManager: NetworkManagerProtocol,_ article: ArticleModel) {
        self.coordinator = coordinator
        self.networkManager = networkManager
        self.article = article
    }
    
}

// MARK: - DetailArticleViewModelProtocol

extension DetailArticleViewModel: DetailArticleViewModelProtocol {
    
    func fetchFullText() {
        guard article.fullText.value == nil else { return }
        let fullTextId = article.textId
        networkManager.fetchData(by: .fullText(fullTextId)) { [weak article, weak loadingState] (result: Result<ArticleTextData, NetworkError>) in
            loadingState?.accept(.loading)
            switch result {
            case .success(let articleTextData):
                let fullText = articleTextData.body
                article?.fullText.accept(fullText)
                loadingState?.accept(.loaded)
            case .failure(let netError):
                print("Full text fetching failure: \(netError.description)")
                loadingState?.accept(.failed(netError.description))
            }
        }
    }
    
}
