//
//  ArticleDetailRouter.swift
//  VIPER
//
//  Created by okano on 2020/01/18.
//  Copyright © 2020 ryookano. All rights reserved.
//

import UIKit

protocol ArticleDetailWireframe: class {
    var viewController: UIViewController? { get set }
    init(viewController: UIViewController?)
    static func assembleModules(article: Article) -> UIViewController
}

class ArticleDetailRouter: ArticleDetailWireframe {
    weak var viewController: UIViewController?

    required init(viewController: UIViewController?) {
        self.viewController = viewController
    }

    static func assembleModules(article: Article) -> UIViewController {
        let view = ArticleDetailViewController.instantiate()
        let router = ArticleDetailRouter(viewController: view)
        let presenter = ArticleDetailViewPresenter(view: view, router: router, article: article)

        view.presenter = presenter

        return view
    }
}

