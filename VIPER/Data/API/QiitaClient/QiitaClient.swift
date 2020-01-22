//
//  QiitaClient.swift
//  VIPER
//
//  Created by ryookano on 2020/01/16.
//  Copyright © 2020 ryookano. All rights reserved.
//

import UIKit

protocol QiitaRequestable: AnyObject {

    func send<Request: QiitaRequest>(request: Request, completion: @escaping (Result<Request.Response, Error>) -> ())
}

class QiitaClient {
    private let session: URLSession

    init(session: URLSession = {
            let configuration = URLSessionConfiguration.default
            let session = URLSession(configuration: configuration)
            return session
        }()
    ) {
        self.session = session
    }
}

extension QiitaClient: QiitaRequestable {

    func send<Request: QiitaRequest>(request: Request, completion: @escaping (Result<Request.Response, Error>) -> ()) {
        let urlRequest = request.buildURLRequest()
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            switch (data, response, error) {
            case (_, _, let error?):
                print(error.localizedDescription)
                completion(.failure(error))
            case (let data?, let response?, _):
                do {
                    let response = try request.response(from: data, urlResponse: response)
                    completion(.success(response))
                } catch {
                    completion(.failure(NSError()))
                }
            default:
                completion(.failure(NSError()))
            }
        }

        task.resume()
    }
}
