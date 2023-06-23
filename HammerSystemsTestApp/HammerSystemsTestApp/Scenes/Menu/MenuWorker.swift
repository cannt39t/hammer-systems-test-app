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

class MenuWorker {
    
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
                HSCategory(index: 0, name: "Пицца", isSelected: true),
                HSCategory(index: 1, name: "Комбо", isSelected: false),
                HSCategory(index: 2, name: "Десерты", isSelected: false),
                HSCategory(index: 3, name: "Напитки", isSelected: false)
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
