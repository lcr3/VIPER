//
//  ArticleDetailViewController.swift
//  VIPER
//
//  Created by okano on 2020/01/18.
//  Copyright © 2020 ryookano. All rights reserved.
//

import UIKit
import WebKit

protocol ArticleDetailView: class {
    
    func load(request urlRequest: URLRequest)
}

final class ArticleDetailViewController: UIViewController, StoryboardInstantiatable {
    static var instantiateType: StoryboardInstantiateType { .initial }
    var presenter: ArticleDetailViewPresentation!
    
    @IBOutlet private weak var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
    }
}

extension ArticleDetailViewController: ArticleDetailView {

    func load(request urlRequest: URLRequest) {
        webView.load(urlRequest)
    }
}
