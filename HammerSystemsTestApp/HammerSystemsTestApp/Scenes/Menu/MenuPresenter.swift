//
//  MenuPresenter.swift
//  HammerSystemsTestApp
//
//  Created by Илья Казначеев on 23.06.2023.
//  Copyright (c) cantt39t. All rights reserved.
//  see https://github.com/cannt39t
//


import UIKit


protocol MenuPresentationLogic {
    func presentActions(response: Menu.Action.Response)
    func presentCategories(response: Menu.Category.Response)
    func presentProducts(response: Menu.Product.Response)
}

final class MenuPresenter: MenuPresentationLogic {
    
    weak var viewController: MenuDisplayLogic?
    
    func presentActions(response: Menu.Action.Response) {
        if response.ok {
            let actions = response.actions.map { Menu.Action.ViewModel(
                imageURL: $0.imageURL
            )}
            viewController?.displayActions(viewModel: actions)
        } else {
            viewController?.showError(with: response.message ?? "Unknown error")
        }
    }
    
    func presentCategories(response: Menu.Category.Response) {
        if response.ok {
            var categories = [Menu.Category.ViewModel]()
            response.categories.enumerated().forEach { index, val in
                categories.append(Menu.Category.ViewModel(
                    index: index,
                    name: val.name,
                    isSelected: index == 0)
                )
            }
            viewController?.displayCategories(viewModel: categories)
        } else {
            viewController?.showError(with: response.message ?? "Unknown error")
        }
    }
    
    func presentProducts(response: Menu.Product.Response) {
        if response.ok {
            let products = response.products.map { Menu.Product.ViewModel(
                name: $0.nombre,
                decryption: $0.descripcion,
                price: Int($0.precio ?? "345") ?? 345,
                imageURL: $0.linkImagen)
            }
            viewController?.displayProducts(viewModel: products)
        } else {
            viewController?.showError(with: response.message ?? "Unknown error")
        }
    }
}
