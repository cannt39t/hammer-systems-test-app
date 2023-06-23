//
//  ActionCollectionViewCell.swift
//  HammerSystemsTestApp
//
//  Created by Илья Казначеев on 23.06.2023.
//

import UIKit

class ActionCollectionViewCell: BaseCell {
    
    static let identifier = "ActionCollectionViewCell"
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    func configure(with action: Menu.Action.ViewModel) {
        let image = UIImage(named: action.imageURL!)
        imageView.image = image
    }
}

extension ActionCollectionViewCell {
    
    override func setupViews() {
        super.setupViews()
        setupView(imageView)
    }
    
    override func constraintViews() {
        super.constraintViews()
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor)
        ])
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
}
