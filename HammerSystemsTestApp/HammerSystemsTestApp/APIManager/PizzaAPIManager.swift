//
//  PizzaAPIManager.swift
//  HammerSystemsTestApp
//
//  Created by Илья Казначеев on 23.06.2023.
//

import Foundation

final class PizzaAPIManager {
    
    let headers = [
        "X-RapidAPI-Key": "98b07ee665msh5f923589946f2fcp1c5b51jsncaa7695ea568",
        "X-RapidAPI-Host": "pizzaallapala.p.rapidapi.com"
    ]
    
    func fetchData(completion: @escaping (Result<Data, Error>) -> Void) {
        let url = URL(string: "https://pizzaallapala.p.rapidapi.com/productos")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
            completion(.success(cachedResponse.data))
            return
        }
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                if let data = data, let response = response as? HTTPURLResponse {
                    if response.statusCode == 200 {
                        let cachedResponse = CachedURLResponse(response: response, data: data)
                        URLCache.shared.storeCachedResponse(cachedResponse, for: request)
                        completion(.success(data))
                    } else {
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

