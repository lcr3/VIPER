//
//  AbstractRequest.swift
//  VIPER
//
//  Created by okano on 2020/05/02.
//
import Alamofire

struct AbstractRequest<R: Decodable> {
    typealias Response = R

    var urlString: URLConvertible
    var method: Alamofire.HTTPMethod
    var parameters: [String: Any]?
}
