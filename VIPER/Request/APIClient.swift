//
//  APIClient.swift
//  VIPER
//
//  Created by okano on 2020/05/02.
//

import Alamofire

protocol APIRequestable: AnyObject {
    func request<R>(request: AbstractRequest<R>, completion: @escaping (Result<R, Error>) -> Void)
}

class APIClient {
}

extension APIClient: APIRequestable {
    func request<R>(request: AbstractRequest<R>, completion: @escaping (Result<R, Error>) -> Void) where R: Decodable {
        let afRequest = AF.request(
            request.urlString,
            method: request.method,
            parameters: request.parameters,
            encoding: JSONEncoding.default)

        afRequest.validate(statusCode: 200..<300).response { response in
            if let resposeError = response.error {
                completion(.failure(resposeError))
                return
            }

            guard let responseData = response.data else {
                completion(.failure(APIError.responseDataEmptyError))
                return
            }
            do {
                let result = try JSONDecoder().decode(R.self, from: responseData)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
