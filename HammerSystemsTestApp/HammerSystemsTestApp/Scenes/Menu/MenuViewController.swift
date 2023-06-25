//
//  MenuViewController.swift
//  HammerSystemsTestApp
//
//  Created by Илья Казначеев on 23.06.2023.
//  Copyright (c) cantt39t. All rights reserved.
//  see https://github.com/cannt39t
//


import UIKit

protocol MenuViewControllerHeaderDelegate: AnyObject {
    var canChange: Bool { get set }
    func moveToCategory(with index: Int)
}

protocol MenuDisplayLogic: AnyObject {
    
    func displayActions(viewModel: [Menu.Action.ViewModel])
    func displayCategories(viewModel: [Menu.Category.ViewModel])
    func displayProducts(viewModel: [Menu.Product.ViewModel])
    func showError(with message: String)
}

final class MenuViewController: UIViewController, MenuDisplayLogic {
    
    var interactor: MenuBusinessLogic?
    var router: (NSObjectProtocol & MenuRoutingLogic & MenuDataPassing)?
    
    // MARK: View Models
    var actionsViewModel: [Menu.Action.ViewModel] = []
    var categoryViewModel: [Menu.Category.ViewModel] = []
    var productViewModel: [Menu.Product.ViewModel] = []
    
    // MARK: Views
    var collectionView: UICollectionView!
    weak var categoryHeader: CategoryHeader?
    weak var actionsHeader: ActionHeader?
    
    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    private func setup() {
        let viewController = self
        let interactor = MenuInteractor()
        let presenter = MenuPresenter()
        let router = MenuRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupController()
        setupCollectionView()
        fetchData()
    }
    
    private func setupController() {
        view.backgroundColor = R.Color.background
        let button = HSChooseButton()
        button.addTarget(self, action: #selector(didTapOnCityButton), for: .touchUpInside)
        button.setTitle(R.Strings.Menu.city)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = R.Color.background
        appearance.shadowColor = .clear
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    // MARK: Requests
    
    func fetchData() {
        let requestActions = Menu.Action.Request()
        let requestCategories = Menu.Category.Request()
        let requestProducts = Menu.Product.Request()
        interactor?.getActions(request: requestActions)
        interactor?.getCategories(request: requestCategories)
        interactor?.getProducts(request: requestProducts)
    }
    
    func displayActions(viewModel: [Menu.Action.ViewModel]) {
        actionsViewModel = viewModel
    }
    
    func displayCategories(viewModel: [Menu.Category.ViewModel]) {
        categoryViewModel = viewModel
    }
    
    func displayProducts(viewModel: [Menu.Product.ViewModel]) {
        productViewModel = viewModel
        DispatchQueue.main.async { [weak collectionView] in
            collectionView?.reloadData()
        }
    }
}


@objc extension MenuViewController {
    
    func didTapOnCityButton() {
        // Choose city action
    }
}

extension MenuViewController {
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = R.Color.background
        collectionView.showsVerticalScrollIndicator = false
        
        view.setupView(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.identifier)
        collectionView.register(ActionHeader.self, forSupplementaryViewOfKind: ActionHeader.identifier, withReuseIdentifier: ActionHeader.identifier)
        collectionView.register(CategoryHeader.self, forSupplementaryViewOfKind: CategoryHeader.identifier, withReuseIdentifier: CategoryHeader.identifier)
    }
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { [weak self] (index, enviroment) -> NSCollectionLayoutSection? in
            return self?.createSectionFor(index: index, enviroment: enviroment)
        })
        
        let actionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(206))
        let actionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: actionHeaderSize, elementKind: ActionHeader.identifier, alignment: .top)
        actionHeader.zIndex = -1
        
        let globalHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(68))
        let globalHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: globalHeaderSize, elementKind: CategoryHeader.identifier, alignment: .top)
        globalHeader.pinToVisibleBounds = true
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.boundarySupplementaryItems = [actionHeader, globalHeader]
        layout.configuration = config
        
        return layout
    }
    
    private func createSectionFor(index: Int, enviroment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        switch index {
            default:
                return setupFirstSection()
        }
    }
    
    
    private func setupFirstSection() -> NSCollectionLayoutSection {
        // item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(174))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
}

extension MenuViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let categoryHeader = categoryHeader else { return }
        if indexPath.section == categoryHeader.selectedCategory {
            categoryHeader.canChange = true
        }
        
        if categoryHeader.canChange && indexPath.section != categoryHeader.selectedCategory {
            categoryHeader.moveToCategory(with: indexPath.section)
            categoryHeader.selectedCategory = indexPath.section
        }
    }
}


extension MenuViewController: UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.identifier, for: indexPath) as! ProductCell
        if indexPath.section == 0 && indexPath.item == 0 {
            cell.layer.cornerRadius = 25
            cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else {
            cell .layer.cornerRadius = 0
        }
        cell.configure(with: productViewModel[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        productViewModel.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == CategoryHeader.identifier {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CategoryHeader.identifier, for: indexPath) as! CategoryHeader
            header.delegate = self
            header.categories = categoryViewModel
            self.categoryHeader = header
            return header
        } else {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ActionHeader.identifier, for: indexPath) as! ActionHeader
            self.actionsHeader = header
            header.actions = actionsViewModel
            return header
        }
    }
}

extension MenuViewController: CategoryHeaderDelegate {
    
    func moveToSection(at sectionIndex: Int) {
        guard let categoryHeader = categoryHeader else { return }
        categoryHeader.canChange = false
        collectionView.scrollToItem(at: IndexPath(row: 0, section: sectionIndex), at: .top, animated: true)
    }
}

extension MenuViewController {
    
    func showError(with message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

