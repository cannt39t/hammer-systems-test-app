//
//  MenuModels.swift
//  HammerSystemsTestApp
//
//  Created by Илья Казначеев on 23.06.2023.
//  Copyright (c) cantt39t. All rights reserved.
//  see https://github.com/cannt39t
//


import UIKit


enum Menu {
    
    enum Action {
        
        struct Request {
            
        }
        
        struct Response {
            let message: String?
            let ok: Bool
            let actions: [HSAction]
        }
        
        struct ViewModel {
            let imageURL: String?
        }
    }
    
    enum Category {
        
        struct Request {
            
        }
        
        struct Response {
            let message: String?
            let ok: Bool
            let categories: [HSCategory]
        }
        
        struct ViewModel {
            let index: Int
            let name: String
            var isSelected: Bool
        }
    }
    
    enum Product {
        
        struct Request {
            
        }
        
        struct Response: Codable {
            let message: String?
            let ok: Bool
            let products: [HSProduct]
        }
        
        struct ViewModel {
            let name: String
            let decryption: String
            let price: Int
            let imageURL: String?
        }
    }
}
