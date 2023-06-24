//
//  CategoryCollectionReusableView.swift
//  HammerSystemsTestApp
//
//  Created by Илья Казначеев on 22.06.2023.
//

import UIKit

protocol CategoryHeaderDelegate: AnyObject {
    func moveToSection(at sectionIndex: Int)
}

final class CategoryHeader: BaseHeader {
        
    static let identifier = "CategoryHeader"
    weak var delegate: CategoryHeaderDelegate!
    var selectedCategory: Int = 0
    var categories: [Menu.Category.ViewModel] = []
    var canChange = true
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        
        return collectionView
    }()
}

extension CategoryHeader: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
        cell.configure(with: categories[indexPath.item])
        return cell
    }
}

extension CategoryHeader: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        unselectCategory()
        selectCategory(at: indexPath)
        delegate.moveToSection(at: indexPath.item)
    }
    
    private func unselectCategory() {
        let previousSelectedCell = collectionView.cellForItem(at: IndexPath(row: selectedCategory, section: 0)) as! CategoryCollectionViewCell
        categories[selectedCategory].isSelected = false
        previousSelectedCell.makeUnselected()
    }
    
    private func selectCategory(at indexPath: IndexPath) {
        selectedCategory = indexPath.item
        let previousSelectedCell = collectionView.cellForItem(at: indexPath) as! CategoryCollectionViewCell
        previousSelectedCell.makeSelected()
        categories[indexPath.row].isSelected = true
        moveToCell(with: indexPath)
    }
    
    private func moveToCell(with indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

extension CategoryHeader {
    
    override func setupViews() {
        super.setupViews()
        
        setupView(collectionView)
    }
    
    override func constraintViews() {
        super.constraintViews()
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: -12),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        
        backgroundColor = R.Color.background
        collectionView.reloadData()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension CategoryHeader: MenuViewControllerHeaderDelegate {
    

    func moveToCategory(with index: Int) {
        unselectCategory()
        let indexPath = IndexPath(item: index, section: 0)
        selectCategory(at: indexPath)
    }
}
