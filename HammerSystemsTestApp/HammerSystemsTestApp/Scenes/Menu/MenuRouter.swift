//
//  MenuRouter.swift
//  HammerSystemsTestApp
//
//  Created by Илья Казначеев on 23.06.2023.
//  Copyright (c) cantt39t. All rights reserved.
//  see https://github.com/cannt39t
//


import UIKit


@objc protocol MenuRoutingLogic {
    
}

protocol MenuDataPassing {
    var dataStore: MenuDataStore? { get }
}

class MenuRouter: NSObject, MenuRoutingLogic, MenuDataPassing {
    weak var viewController: MenuViewController?
    var dataStore: MenuDataStore?
}
