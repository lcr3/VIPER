//
//  SearchArticleInteractor.swift
//  VIPER
//
//  Created by ryookano on 2020/01/16.
//  Copyright © 2020 ryookano. All rights reserved.
//

import Foundation

protocol SearchArticleUsecase: AnyObject {

    func fetchArticles(keyword: String,
                           completion: @escaping (Result<[Article], Error>) -> Void)
}

class SearchArticleInteractor {
    // Qiitaに問い合わせるためのAPIクライアント
    // Interactorのテスト時にAPIクライアントをMockに差し替えて任意のレスポンスを返すようにするため
    private let client: QiitaRequestable

    init(client: QiitaRequestable = QiitaClient()) {
        self.client = client
    }
}

extension SearchArticleInteractor: SearchArticleUsecase {
    func fetchArticles(keyword: String,
                           completion: @escaping (Result<[Article], Error>) -> Void) {
        let request = QiitaAPI.SearchArticles(keyword: keyword)
        client.send(request: request) { result in
            completion(result)
        }
    }
}
