//
//  HSPriceButton.swift
//  HammerSystemsTestApp
//
//  Created by Илья Казначеев on 23.06.2023.
//

import UIKit


final class HSPriceButton: BaseButton {
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = R.Font.SF_UI_Display(with: 13, type: .regular)
        label.textColor = R.Color.primary
        return label
    }()
    
    func configure(with price: Int) {
        priceLabel.text = "от \(price) р"
    }
}

extension HSPriceButton {
    
    override func setupViews() {
        super.setupViews()
        setupView(priceLabel)
    }
    
    override func constraintViews() {
        super.constraintViews()
        
        NSLayoutConstraint.activate([
            priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 19),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -19),
            priceLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            priceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ])
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        makeSystem(self)
        layer.cornerRadius = 6
        layer.masksToBounds = true
        layer.borderColor = R.Color.primary!.cgColor
        layer.borderWidth = 1
    }
}
