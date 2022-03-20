//
//  TodoListBuilder.swift
//  GetirTodo
//
//  Created by Hüsamettin  Eyibil on 20.03.2022.
//

import UIKit

class TodoListBuilder {
    static func build() -> TodoListViewController {
        let viewController = TodoListViewController()
        viewController.viewModel = TodoListViewModel(manager: appContainer.manager)
        return viewController
    }
}
