//
//  ArticleListRouter.swift
//  VIPER
//
//  Created by ryookano on 2020/01/16.
//  Copyright © 2020 ryookano. All rights reserved.
//

import UIKit

protocol ArticleListWireframe: AnyObject {

    func showArticleDetail(_ article: Article)
}

class ArticleListRouter {
    // 画面遷移のためにViewControllerが必要。initで受け取る
    private unowned let viewController: UIViewController

    private init(viewController: UIViewController) {
        self.viewController = viewController
    }

    // DI
    static func assembleModules() -> UIViewController {
        let view = ArticleListViewController.instantiate()
        let router = ArticleListRouter(viewController: view)
        let articleInteractor = SearchArticleInteractor()
        // 生成し、initの引数で渡す
        let presenter = ArticleListViewPresenter(view: view,
                                                    router: router,
                                                    articleInteractor: articleInteractor)
        view.presenter = presenter    // ViewにPresenterを設定

        return view
    }
}

// Routerのプロトコルに準拠する
// 遷移する各画面ごとにメソッドを定義
extension ArticleListRouter: ArticleListWireframe {

    func showArticleDetail(_ article: Article) {
        // 詳細画面のRouterに依存関係の解決を依頼
        let detailView = ArticleDetailRouter.assembleModules(article: article)
        // 詳細画面に遷移
        // ここで、init時に受け取ったViewControllerを使う
        viewController.navigationController?.pushViewController(detailView, animated: true)
    }
}
