//
//  SceneDelegate.swift
//  HammerSystemsTestApp
//
//  Created by Илья Казначеев on 22.06.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//        URLCache.shared.removeAllCachedResponses()
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        window.rootViewController = TabBarViewController()
        window.makeKeyAndVisible()
    }
}

