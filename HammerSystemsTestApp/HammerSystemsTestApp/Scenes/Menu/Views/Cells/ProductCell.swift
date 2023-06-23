//
//  ProductCell.swift
//  HammerSystemsTestApp
//
//  Created by Илья Казначеев on 23.06.2023.
//

import UIKit
import SDWebImage


final class ProductCell: BaseCell {
    
    static let identifier = "ProductCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = R.Font.SF_UI_Display(with: 17, type: .semibold)
        label.textColor = R.Color.label
        return label
    }()
    
    private let decryptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 4
        label.font = R.Font.SF_UI_Display(with: 13, type: .regular)
        label.textColor = R.Color.secondaryLabel
        return label
    }()
    
    private var textStack: UIStackView!
    private let priceButton: HSPriceButton = .init()
    
    func configure(with product: Menu.Product.ViewModel) {
        loadImage(from: product.imageURL)
        nameLabel.text = product.name
        decryptionLabel.text = product.decryption
        priceButton.configure(with: product.price)
    }
    
    private func loadImage(from URLString: String?) {
        guard let imageURLString = URLString, let imageURL = URL(string: imageURLString) else {
            imageView.image = R.Images.defaultImage?.withRenderingMode(.alwaysOriginal).withTintColor(R.Color.secondaryLabel!)
            return
        }
        imageView.sd_setImage(with: imageURL, placeholderImage: nil, options: [.highPriority])
    }
}

extension ProductCell {
    
    override func setupViews() {
        super.setupViews()
        textStack = UIStackView(arrangedSubviews: [nameLabel, decryptionLabel])
        textStack.alignment = .leading
        textStack.spacing = 16
        textStack.axis = .vertical
        setupView(textStack)
        setupView(imageView)
        setupView(priceButton)
    }
    
    override func constraintViews() {
        super.constraintViews()
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 132),
            imageView.widthAnchor.constraint(equalToConstant: 132),
            
            textStack.topAnchor.constraint(equalTo: imageView.topAnchor),
            textStack.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 32),
            textStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            priceButton.topAnchor.constraint(equalTo: textStack.bottomAnchor, constant: 16),
            priceButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        backgroundColor = .white
        addBottomBorder(with: R.Color.separator!, height: 1)
    }
}
