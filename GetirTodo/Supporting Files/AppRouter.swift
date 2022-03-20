//
//  AppRouter.swift
//  GetirTodo
//
//  Created by Hüsamettin  Eyibil on 20.03.2022.
//

import Foundation
import UIKit

class AppRouter {
    func start(scene: UIWindowScene) -> UIWindow {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController(rootViewController: TodoListViewController())
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        window.windowScene = scene
        return window
    }
}
