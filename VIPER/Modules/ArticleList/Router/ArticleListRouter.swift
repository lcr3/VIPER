//
//  ArticleListRouter.swift
//  VIPER
//
//  Created by ryookano on 2020/01/16.
//  Copyright © 2020 ryookano. All rights reserved.
//

import UIKit

protocol ArticleListWireframe: class {
    var viewController: UIViewController? { get set }
    init(viewController: UIViewController?)
    static func createArticleListModule() -> UIViewController
     // PRESENTER -> WIREFRAME
    func showArticleDetail(_article: Article)
}

class ArticleListRouter: ArticleListWireframe {
    
    weak var viewController: UIViewController?
    
    required init(viewController: UIViewController?) {
        self.viewController = viewController
    }
    
    static func createArticleListModule() -> UIViewController {
        let view = ArticleListViewController.instantiate()
        let router = ArticleListRouter(viewController: view)
        let interactor = SearchArticleInteractor()

        let presenter = ArticleListViewPresenter(view: view, router: router, interactor: interactor)
        view.presenter = presenter
        
        return UINavigationController(rootViewController: view)
    }
    
    
    func showArticleDetail(_article: Article) {
        let detailView = ArticleDetailRouter.assembleModules(article: _article)
        self.viewController?.navigationController?.pushViewController(detailView, animated: true)
    }
}
