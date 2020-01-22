//
//  ArticleDetailRouter.swift
//  VIPER
//
//  Created by okano on 2020/01/18.
//  Copyright © 2020 ryookano. All rights reserved.
//

import UIKit

protocol ArticleDetailWireframe: class {
    
}

class ArticleDetailRouter {

    private unowned let viewController: UIViewController

    private init(viewController: UIViewController) {
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

extension ArticleDetailRouter: ArticleDetailWireframe {

}
