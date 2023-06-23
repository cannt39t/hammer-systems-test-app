//
//  BaseHeader.swift
//  HammerSystemsTestApp
//
//  Created by Илья Казначеев on 22.06.2023.
//

import UIKit


class BaseHeader: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        constraintViews()
        configureAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

@objc extension BaseHeader {
    
    func setupViews() { }
    func constraintViews() { }
    func configureAppearance() { }
}
