//
//  TodoDetailBuilder.swift
//  GetirTodo
//
//  Created by Hüsamettin  Eyibil on 22.03.2022.
//

import Foundation

class TodoDetailBuilder {
    static func build(item: TodoItem) -> TodoDetailViewController {
        let viewController = TodoDetailViewController()
        viewController.viewModel = TodoDetailViewModel(item: item, manager: appContainer.manager)
        return viewController
    }
}
