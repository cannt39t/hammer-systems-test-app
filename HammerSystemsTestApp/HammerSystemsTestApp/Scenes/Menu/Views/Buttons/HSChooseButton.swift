//
//  ChooseButton.swift
//  HammerSystemsTestApp
//
//  Created by Илья Казначеев on 22.06.2023.
//

import UIKit


final class HSChooseButton: BaseButton {
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = R.Color.label
        label.textAlignment = .center
        label.font = R.Font.SF_UI_Display(with: 17, type: .medium)
        return label
    }()
    
    private let iconView: UIImageView = {
        let view = UIImageView()
        
        view.image = R.Images.downArrow?.withRenderingMode(.alwaysOriginal)
        view.tintColor = R.Color.chevron
        return view
    }()
    
    func setTitle(_ title: String?) {
        label.text = title
    }
}

extension HSChooseButton {
    
    override func setupViews() {
        super.setupViews()
        setupView(label)
        setupView(iconView)
    }
    
    override func constraintViews() {
        super.constraintViews()
        NSLayoutConstraint.activate([
            iconView.centerYAnchor.constraint(equalTo: label.centerYAnchor, constant: 1),
            iconView.trailingAnchor.constraint(equalTo: trailingAnchor),
            iconView.heightAnchor.constraint(equalToConstant: 8),
            iconView.widthAnchor.constraint(equalToConstant: 14),
            
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.trailingAnchor.constraint(equalTo: iconView.leadingAnchor, constant: -8),
            label.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        makeSystem(self)
    }
}
