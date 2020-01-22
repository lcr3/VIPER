//
//  ArticleListViewPresenter.swift
//  VIPER
//
//  Created by ryookano on 2020/01/16.
//  Copyright © 2020 ryookano. All rights reserved.
//

import Foundation

protocol ArticleListViewPresentation: AnyObject {

    func viewDidLoad()
    func searchButtonDidPush(searchText: String)
    func refreshControlValueChanged(searchText: String)
    func didSelectRow(at indexPath: IndexPath)
}

// MARK:- Presenter
class ArticleListViewPresenter {

    // View, Interactor, Routerへのアクセスはprotocolを介して行う
    // Viewは循環参照にならないよう`weak`プロパティ
    private weak var view: ArticleListView?
    private let router: ArticleListWireframe
    private let articleInteractor: SearchArticleUsecase

    private var searchText: String = "" {
        didSet {
            guard !searchText.isEmpty else { return }

            view?.setLastSearchText(searchText)
            view?.showRefreshView()

            // Interactorにデータ取得処理を依頼
            // `@escaping`がついているクロージャの場合は循環参照にならないよう`[weak self]`でキャプチャ
            articleInteractor.fetchArticles(keyword: searchText) { [weak self] result in
                switch result {
                case .success(let articles):
                    self?.articles = articles
                case .failure:
                    self?.articles.removeAll()
                    self?.view?.showErrorMessageView(reason: "エラーが発生しました")
                }
            }
//            repositoryInteractor.fetchRepositories(keyword: searchText) { [weak self] result in
//                switch result {
//                case .success(let repositories):
//                    self?.repositories = repositories
//                case .failure:
//                    self?.repositories.removeAll()
//                    self?.view?.showErrorMessageView(reason: "エラーが発生しました")
//                }
//            }
        }
    }

    private var articles: [Article] = [] {
        didSet {
            view?.updateArticles(articles)
        }
    }

    init(view: ArticleListView,
         router: ArticleListWireframe,
         articleInteractor: SearchArticleUsecase) {
        self.view = view
        self.router = router
        self.articleInteractor = articleInteractor
    }

}

// Presenterのプロトコルに準拠する
extension ArticleListViewPresenter: ArticleListViewPresentation {

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
        router.showArticleDetail(article) // Routerに画面遷移を依頼
    }
}
