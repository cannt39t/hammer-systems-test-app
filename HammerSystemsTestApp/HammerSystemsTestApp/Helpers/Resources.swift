//
//  R.swift
//  HammerSystemsTestApp
//
//  Created by Илья Казначеев on 22.06.2023.
//

import UIKit


enum R {
    
    enum Color {
        static let background = UIColor(named: "background")
        static let label = UIColor(named: "label")
        static let secondaryLabel = UIColor(named: "secondaryLabel")
        static let chevron = UIColor(named: "chevron")
        static let separator = UIColor(named: "separator")
        static let primary = UIColor(named: "primary")
        static let tabbarTint = UIColor(named: "tabbar_tint")
        
        enum categoryCell {
            static let backgroundSelected = UIColor(named: "category_selected_background")
            static let backgroundUnselected = UIColor.clear
            static let textSelected = UIColor(named: "primary")
            static let textUnselected = UIColor(named: "category_unselected")
            static let borderUnselected = UIColor(named: "category_unselected")
        }
    }
    
    enum Images {
        static let downArrow = UIImage(named: "downArrow")
        static let defaultImage = UIImage(systemName: "photo.circle")
        
        static func getTitleFor(tab: Tabs) -> UIImage? {
            switch tab {
                case .menu:
                    return UIImage(named: "menu")
                case .contacts:
                    return UIImage(named: "contact")
                case .cart:
                    return UIImage(named: "cart")
                case .profile:
                    return UIImage(named: "profile")
            }
        }
    }
    
    enum Strings {
        
        enum Menu {
            static let city = "Москва"
        }
        
        static func getTitleFor(tab: Tabs) -> String {
            switch tab {
                case .menu:
                    return "Меню"
                case .contacts:
                    return "Контакты"
                case .cart:
                    return "Корзина"
                case .profile:
                    return "Профиль"
            }
        }
    }
    
    enum Font {
        static func SF_UI_Display(with size: CGFloat, type: UIFont.Weight) -> UIFont {
            return .systemFont(ofSize: size, weight: type)
        }
    }
}
