//
//  HSProduct.swift
//  HammerSystemsTestApp
//
//  Created by Илья Казначеев on 23.06.2023.
//

import Foundation

struct HSProduct: Codable {
    
    let id: Int
    let nombre: String
    let descripcion: String
    let linkImagen: String?
    let precio: String?
    let tasaIva: String?
    let vendible: Int
    let borrado: Int?
    let stockRequerido: Int?
    let createdAt: String
}


