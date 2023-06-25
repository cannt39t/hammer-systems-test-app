//
//  MenuWorker.swift
//  HammerSystemsTestApp
//
//  Created by Илья Казначеев on 23.06.2023.
//  Copyright (c) cantt39t. All rights reserved.
//  see https://github.com/cannt39t
//


import UIKit

typealias fetchResponseActions = (Result<[HSAction], Error>) -> Void
typealias fetchResponseCategories = (Result<[HSCategory], Error>) -> Void
typealias fetchResponseProducts = (Result<[HSProduct], Error>) -> Void

struct ProductResponse: Codable {
    var productos: [HSProduct]
}

final class MenuWorker {
    
    private let APIManager = PizzaAPIManager()
    
    func getActions(completion: @escaping fetchResponseActions) {
        DispatchQueue.global(qos: .default).async {
            let actions = [
                HSAction(imageURL: "action_1"),
                HSAction(imageURL: "action_2")
            ]
            completion(.success(actions))
        }
    }
    
    func getCategories(completion: @escaping fetchResponseCategories) {
        DispatchQueue.global(qos: .default).async {
            let categories = [
                HSCategory(name: "Пицца"),
                HSCategory(name: "Комбо"),
                HSCategory(name: "Десерты"),
                HSCategory(name: "Напитки")
            ]
            completion(.success(categories))
        }
    }
    
    func getProducts(completion: @escaping fetchResponseProducts) {
        DispatchQueue.global(qos: .default).async { [weak APIManager] in
            APIManager?.fetchData(completion: { result in
                switch result {
                    case .failure(let error):
                        completion(.failure(error))
                    case .success(let data):
                        do {
                            let decoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .convertFromSnakeCase
                            let responseModel = try decoder.decode(ProductResponse.self, from: data)
                            completion(.success(responseModel.productos))
                        } catch {
                            completion(.failure(error))
                        }
                }
            })
        }
    }
}
