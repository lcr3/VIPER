//
//  ArticleListViewPresenterTests.swift
//  VIPERTests
//
//  Created by okano on 2020/01/18.
//  Copyright © 2020 ryookano. All rights reserved.
//

import XCTest


class ArticleListViewPresenterTests: XCTestCase {

    var articleListViewPresenter: ArticleListViewPresenter!

    class MockInteractor: SearchArticleInteractor {
//        override func fetchArticles(keyword: String, completion: @escaping (Result<[Article], Error>) -> Void) {
//        }
        
    }

    
    class MockRouter: ArticleListWireframe {
        func showArticleDetail(_ article: Article) {
            
        }
    }
    
    var mockInteractor: MockInteractor!
    var mockRouter: MockRouter!
//    var mockInterface: MockInterface!

    
    override func setUp() {
        super.setUp()
        mockRouter = MockRouter()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
