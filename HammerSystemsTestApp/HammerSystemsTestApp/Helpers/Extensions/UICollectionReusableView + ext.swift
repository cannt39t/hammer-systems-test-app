//
//  UICollectionReusableView + ext.swift
//  HammerSystemsTestApp
//
//  Created by Илья Казначеев on 26.06.2023.
//

import UIKit


extension UICollectionReusableView {
    
    static var identifier: String {
        .init(describing: self)
    }
}
