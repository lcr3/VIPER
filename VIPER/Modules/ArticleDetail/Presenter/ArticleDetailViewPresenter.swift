//
//  ArticleDetailViewPresenter.swift
//  VIPER
//
//  Created by okano on 2020/01/18.
//  Copyright © 2020 ryookano. All rights reserved.
//

import Foundation

protocol ArticleDetailViewPresentation: class {
    
    func viewDidLoad()
}

class ArticleDetailViewPresenter {

    private weak var view: ArticleDetailView?
       private let router: ArticleDetailWireframe
       private let article: Article

       init(view: ArticleDetailView, router: ArticleDetailWireframe, article: Article) {
           self.view = view
           self.router = router
           self.article = article
       }
}

extension ArticleDetailViewPresenter: ArticleDetailViewPresentation {

    func viewDidLoad() {
        guard let url = URL(string: article.url) else {
            return
        }
        view?.load(request: URLRequest(url: url))
    }
}
