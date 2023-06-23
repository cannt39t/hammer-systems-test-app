//
//  CategoryCollectionViewCell.swift
//  HammerSystemsTestApp
//
//  Created by Илья Казначеев on 22.06.2023.
//

import UIKit

final class CategoryCollectionViewCell: BaseCell {
    
    
    static let identifier = "CategoryCollectionViewCell"
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    func configure(with category: Menu.Category.ViewModel) {
        nameLabel.text = category.name
        if category.isSelected {
            makeSelected()
        } else {
            makeUnselected()
        }
    }
    
    func makeSelected() {
        nameLabel.font = R.Font.SF_UI_Display(with: 13, type: .bold)
        nameLabel.textColor = R.Color.categoryCell.textSelected
        layer.borderWidth = 0
        layer.borderColor = UIColor.clear.cgColor
        backgroundColor = R.Color.categoryCell.backgroundSelected
    }
    
    func makeUnselected() {
        nameLabel.font = R.Font.SF_UI_Display(with: 13, type: .regular)
        nameLabel.textColor = R.Color.categoryCell.textUnselected
        layer.borderWidth = 1
        layer.borderColor = R.Color.categoryCell.borderUnselected?.cgColor
        backgroundColor = R.Color.categoryCell.backgroundUnselected
    }
}


extension CategoryCollectionViewCell {
    
    override func setupViews() {
        super.setupViews()
        setupView(nameLabel)
    }
    
    override func constraintViews() {
        super.constraintViews()
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
        ])
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        
        layer.cornerRadius = 20
        layer.masksToBounds = true
    }
}

