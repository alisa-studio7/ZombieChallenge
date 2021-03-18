//
//  API.swift
//  ZombieChallenge
//
//  Created by Alisa Sapmun on 16/3/21.
//

import Foundation

protocol Requestable: AnyObject {
    func performRequest<T: Decodable>(request: RequestData, completion: @escaping (UserResult<T>) -> Void)
}

extension Requestable {
    func performRequest<T: Decodable>(request: RequestData, completion: @escaping (UserResult<T>) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            guard let url = URL(string: request.path) else {
                completion(.failure(error: .invalidRequest))
                return
            }
            
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = request.method.rawValue
            
            let session = URLSession(configuration: .default)
            
            let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
                guard let response = response as? HTTPURLResponse, let responseData = data else {
                    completion(.failure(error: .genericError))
                    return
                }
                
                switch response.statusCode {
                case 200:
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(T.self, from: responseData)
                        completion(.success(result: result))
                    } catch {
                        completion(.failure(error: .jsonParsingFailed))
                    }
                case 400:
                    completion(.failure(error: .invalidRequest))
                case 401:
                    completion(.failure(error: .unAuthorized))
                case 403:
                    completion(.failure(error: .forbiddenRequest))
                case 500:
                    completion(.failure(error: .internalServerError))
                case 503:
                    completion(.failure(error: .serviceUnavailabel))
                default:
                    completion(.failure(error: .genericError))
                }
            }
            
            dataTask.resume()
        }
    }
}
