//
//  MenuInteractor.swift
//  HammerSystemsTestApp
//
//  Created by Илья Казначеев on 23.06.2023.
//  Copyright (c) cantt39t. All rights reserved.
//  see https://github.com/cannt39t
//


import UIKit


protocol MenuBusinessLogic {
    
    func getActions(request: Menu.Action.Request)
    func getCategories(request: Menu.Category.Request)
    func getProducts(request: Menu.Product.Request)
}

protocol MenuDataStore {

}

final class MenuInteractor: MenuBusinessLogic, MenuDataStore {
    
    var presenter: MenuPresentationLogic?
    var worker: MenuWorker = MenuWorker()
    
    func getActions(request: Menu.Action.Request) {
        worker.getActions { [weak self] result in
            switch result {
                case .failure(let error):
                    self?.presenter?.presentActions(response: Menu.Action.Response(
                        message: error.localizedDescription,
                        ok: false,
                        actions: []))
                case .success(let actions):
                    self?.presenter?.presentActions(response: Menu.Action.Response(
                        message: nil,
                        ok: true,
                        actions: actions))
            }
        }
    }
    
    func getCategories(request: Menu.Category.Request) {
        worker.getCategories { [weak self] result in
            switch result {
                case .failure(let error):
                    self?.presenter?.presentCategories(response: Menu.Category.Response(
                        message: error.localizedDescription,
                        ok: false,
                        categories: []))
                case .success(let categories):
                    self?.presenter?.presentCategories(response: Menu.Category.Response(
                        message: nil,
                        ok: true,
                        categories: categories))
            }
        }
    }
    
    func getProducts(request: Menu.Product.Request) {
        worker.getProducts { [weak self] result in
            switch result {
                case .failure(let error):
                    self?.presenter?.presentProducts(response: Menu.Product.Response(
                        message: error.localizedDescription,
                        ok: false,
                        products: []))
                case .success(let products):
                    self?.presenter?.presentProducts(response: Menu.Product.Response(
                        message: nil,
                        ok: true,
                        products: products))
            }
        }
    }
}
