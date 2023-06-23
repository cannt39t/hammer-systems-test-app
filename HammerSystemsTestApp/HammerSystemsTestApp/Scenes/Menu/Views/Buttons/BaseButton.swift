//
//  BaseButton.swift
//  HammerSystemsTestApp
//
//  Created by Илья Казначеев on 23.06.2023.
//

import UIKit

class BaseButton: UIButton {
    
    init() {
        super.init(frame: .zero)
        
        setupViews()
        constraintViews()
        configureAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

@objc extension BaseButton {
    
    func setupViews() { }
    func constraintViews() { }
    func configureAppearance() { }
}
