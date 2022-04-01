//
//  SceneDelegate.swift
//  GetirTodo
//
//  Created by Umut Afacan on 21.12.2020.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = appContainer.router.start(scene: windowScene)
    }
}
