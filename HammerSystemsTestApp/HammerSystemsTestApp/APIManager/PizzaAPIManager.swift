//
//  PizzaAPIManager.swift
//  HammerSystemsTestApp
//
//  Created by Илья Казначеев on 23.06.2023.
//

import Foundation

enum HTTPMethod: String {
    case GET
}

final class PizzaAPIManager {
    
    private let endpoint = "/productos"
    
    let headers = [
        "X-RapidAPI-Key": R.API.key,
        "X-RapidAPI-Host": R.API.host
    ]
    
    func fetchData(completion: @escaping (Result<Data, Error>) -> Void) {
        let url = URL(string: "\(R.API.url)\(endpoint)")!
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.GET.rawValue
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
                    completion(.success(cachedResponse.data))
                    return
                }
                completion(.failure(error))
            } else {
                if let data = data, let response = response as? HTTPURLResponse {
                    if response.statusCode == 200 {
                        let cachedResponse = CachedURLResponse(response: response, data: data)
                        URLCache.shared.storeCachedResponse(cachedResponse, for: request)
                        completion(.success(data))
                    } else {
                        if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
                            completion(.success(cachedResponse.data))
                            return
                        }
                        let statusCodeError = NSError(domain: "PizzaAPIErrorDomain",
                                                      code: response.statusCode,
                                                      userInfo: [NSLocalizedDescriptionKey: "Request failed with status code \(response.statusCode)"])
                        completion(.failure(statusCodeError))
                    }
                }
            }
        }
        dataTask.resume()
    }
}

