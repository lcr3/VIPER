//
//  ArticleListViewPresenter.swift
//  VIPER
//
//  Created by ryookano on 2020/01/16.
//  Copyright © 2020 ryookano. All rights reserved.
//

import Foundation

protocol ArticleListViewPresentation: class {
    var view: ArticleListView? { get set }

    init(
        view: ArticleListView?,
        router: ArticleListWireframe,
        interactor: SearchArticleUsecase
    )
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    func searchButtonDidPush(searchText: String)
    func refreshControlValueChanged(searchText: String)
    func didSelectRow(at indexPath: IndexPath)
}

// MARK:- Presenter
class ArticleListViewPresenter: ArticleListViewPresentation {
    weak var view: ArticleListView?
    private let router: ArticleListWireframe
    private let interactor: SearchArticleUsecase

    private var searchText: String = "" {
        didSet {
            guard !searchText.isEmpty else { return }

            view?.showRefreshView()

            interactor.fetchArticles(keyword: searchText) { [weak self] result in
                switch result {
                case .success(let articles):
                    self?.articles = articles
                case .failure:
                    self?.articles.removeAll()
                    self?.view?.showErrorMessageView(reason: "エラーが発生しました")
                }
            }
        }
    }

    private var articles: [Article] = [] {
        didSet {
            view?.updateArticles(articles)
        }
    }

    required init(view: ArticleListView?, router: ArticleListWireframe, interactor: SearchArticleUsecase) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func viewDidLoad() {
        
    }
    
    func searchButtonDidPush(searchText: String) {
        self.searchText = searchText
    }
    
    func refreshControlValueChanged(searchText: String) {
        self.searchText = searchText
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        guard indexPath.row < articles.count else { return }

        let article = articles[indexPath.row]
        router.showArticleDetail(_article: article)
    }
}
