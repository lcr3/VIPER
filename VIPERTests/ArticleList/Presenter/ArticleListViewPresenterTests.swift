//
//  ArticleListViewPresenterTests.swift
//  VIPERTests
//
//  Created by okano on 2020/01/18.
//  Copyright © 2020 ryookano. All rights reserved.
//

import XCTest

class MockArticleListView: UIViewController, ArticleListView {
    var callCount_setLastSearchText = 0
    var callCount_showRefreshView = 0
    var callCount_updateArticles = 0
    var callCount_showErrorMessageView = 0
    
    func setLastSearchText(_ text: String) {
        callCount_setLastSearchText += 1
    }
    
    func showRefreshView() {
        callCount_showRefreshView += 1
    }
    
    func updateArticles(_ Articles: [Article]) {
        callCount_updateArticles += 1
    }
    
    func showErrorMessageView(reason: String) {
        callCount_showErrorMessageView += 1
    }
}

class MockArticleListRouter: ArticleListWireframe {
    var callCount_init = 0
    var callCount_showArticleDetail = 0
    
    var viewController: UIViewController?
    
    init() {
        viewController = UIViewController()
    }
    required init(viewController: UIViewController?) {
        callCount_init += 1
    }
    
    static func createArticleListModule() -> UIViewController {
        let view = ArticleListViewController.instantiate()
        let router = MockArticleListRouter(viewController: view)
        let interactor = MockSearchArticleInteractor()

        let presenter = ArticleListViewPresenter(view: view, router: router, interactor: interactor)
        view.presenter = presenter
        
        return UINavigationController(rootViewController: view)
    }
    
    func showArticleDetail(_article: Article) {
        callCount_showArticleDetail += 1
    }
}

class MockSearchArticleInteractor: SearchArticleUsecase {
    var callCount_fetchArticles = 0
    var succsessFlag = true
    var articles = [Article(title: "dummytitle1", url: "https://qiita.com/lcr/items/f3a60700a08e4767f755"),
                    Article(title: "dummytitle2", url: "https://qiita.com/lcr/items/f33ea048b132e2eca4e7")]
    
    func fetchArticles(keyword: String, completion: @escaping (Result<[Article], Error>) -> Void) {
        callCount_fetchArticles += 1
        
        completion(Result<[Article], Error> { () -> [Article] in
            if succsessFlag {
                return self.articles
            }
            throw NSError(domain: "NetworkError", code: 505, userInfo: nil)
        })
    }
}

class ArticleListViewPresenterTests: XCTestCase {

    var view = MockArticleListView()
    let interactor = MockSearchArticleInteractor()
    let router = MockArticleListRouter()
    var presenter: ArticleListViewPresenter!

    override func setUp() {
        super.setUp()
        presenter = ArticleListViewPresenter(view: view, router: router, interactor: interactor)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testTableViewDidSelectRow() {
        // setup
        let indexPath = IndexPath(row: 0, section: 0)
        presenter.searchButtonDidPush(searchText: "swift")
        sleep(1)
        
        // execute
        presenter.didSelectRow(at: indexPath)

        // expect
        XCTAssertEqual(router.callCount_showArticleDetail, 1)
    }
    
    func testSearchButtonDidPush() {
        // execute
        presenter.searchButtonDidPush(searchText: "swift")

        // expect
        XCTAssertEqual(interactor.callCount_fetchArticles, 1)
    }
}
