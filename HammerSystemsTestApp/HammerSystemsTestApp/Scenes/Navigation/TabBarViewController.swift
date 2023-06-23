//
//  TabBarViewController.swift
//  HammerSystemsTestApp
//
//  Created by Илья Казначеев on 23.06.2023.
//

import UIKit

enum Tabs: Int, CaseIterable {
    case menu, contacts, profile, cart
}

final class TabBarViewController: UITabBarController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        tabBar.tintColor = R.Color.primary
        tabBar.barTintColor = .white
        tabBar.backgroundColor = .white
        tabBar.layer.borderColor = R.Color.separator?.cgColor
        tabBar.layer.borderWidth = 1
        tabBar.layer.masksToBounds = true
        
        let controllers: [UIViewController] = Tabs.allCases.map { tab in
            let controller = UINavigationController(rootViewController: getController(for: tab))
            controller.tabBarItem = UITabBarItem(title: R.Strings.getTitleFor(tab: tab),
                                                 image: R.Images.getTitleFor(tab: tab),
                                                 tag: tab.rawValue)
            return controller
        }
        
        setViewControllers(controllers, animated: false)
    }
    
    private func getController(for tab: Tabs) -> UIViewController {
        switch tab {
            case .menu: return MenuViewController()
            case .contacts: return ContactsViewController()
            case .profile: return ProfileViewController()
            case .cart: return CartViewController()
        }
    }
    
    public func switchToTab(_ tab: Tabs) {
        selectedIndex = tab.rawValue
    }
}
