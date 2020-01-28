//
//  ArticleListRouterTests.swift
//  VIPERTests
//
//  Created by okano on 2020/01/22.
//  Copyright © 2020 ryookano. All rights reserved.
//

import XCTest

class MockArticleListViewPresenter: ArticleListViewPresentation {
    var view: ArticleListView?
    let router: ArticleListWireframe
    let interactor: SearchArticleUsecase

    var callCount_viewDidLoad = 0
    var callCount_searchButtonDidPush = 0
    var callCount_refreshControlValueChanged = 0
    var callCount_didSelectRow = 0

    required init(view: ArticleListView?, router: ArticleListWireframe, interactor: SearchArticleUsecase) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func viewDidLoad() {
        callCount_viewDidLoad += 1
    }
    
    func searchButtonDidPush(searchText: String) {
        callCount_searchButtonDidPush += 1
    }
    
    func refreshControlValueChanged(searchText: String) {
        callCount_refreshControlValueChanged += 1
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        callCount_didSelectRow += 1
    }
}

class ArticleListRouterTests: XCTestCase {

    var view = MockArticleListView()
    let interactor = MockSearchArticleInteractor()
    var router: ArticleListRouter!
    var presenter: MockArticleListViewPresenter!

    override func setUp() {
        super.setUp()
        router = ArticleListRouter(viewController: ArticleListViewController.instantiate())
        presenter = MockArticleListViewPresenter(view: view, router: router, interactor: interactor)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}
