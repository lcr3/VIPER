//
//  QiitaAPI.swift
//  VIPER
//
//  Created by ryookano on 2020/01/16.
//  Copyright © 2020 ryookano. All rights reserved.
//

import UIKit

enum HTTPMethod: String {
    case get = "GET"
}

protocol QiitaRequest {

    associatedtype Response: Decodable

    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem] { get }
}

extension QiitaRequest {
    var baseURL: URL {
        return URL(string: "https://qiita.com/api/v2")!
    }

    func buildURLRequest() -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = queryItems

        var urlRequest = URLRequest(url: url)
        urlRequest.url = components?.url
        urlRequest.httpMethod = method.rawValue

        return urlRequest
    }

    func response(from data: Data, urlResponse: URLResponse) throws -> Response {
        let decoder = JSONDecoder()

        if case (200..<300)? = (urlResponse as? HTTPURLResponse)?.statusCode {
            do {
                let result = try decoder.decode(Response.self, from: data)
                return result
            } catch {
                print(error)
                return error as! Self.Response
            }
        } else {
            throw NSError()
        }
    }
}


class QiitaAPI {
    struct SearchArticles: QiitaRequest {

        typealias Response = [Article]

        let keyword: String

        var method: HTTPMethod {
            return .get
        }

        var path: String {
            return "/items"
        }

        var queryItems: [URLQueryItem] {
            return [URLQueryItem(name: "query", value: keyword)]
        }
    }
}
