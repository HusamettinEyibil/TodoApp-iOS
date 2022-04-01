//
//  TodoDetailViewModel.swift
//  GetirTodo
//
//  Created by Hüsamettin  Eyibil on 22.03.2022.
//

import Foundation

protocol TodoDetailViewModelDelegate: AnyObject {
    func showDetail(item: TodoItem)
    func didCreateNewItem()
}

class TodoDetailViewModel: TodoDetailViewModelProtocol {
    weak var delegate: TodoDetailViewModelDelegate?

    private let manager: CoreDataProtocol!
    private let item: TodoItem

    init(item: TodoItem, manager: CoreDataManager) {
        self.item = item
        self.manager = manager
    }

    func viewDidLoad() {
        delegate?.showDetail(item: item)
    }

    func didTapAddButton(item: TodoItem) {
        manager.createNewItem(item: item) { result in
            switch result {
            case .success(let success):
                debugPrint(success ? "success" : "failure")
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
        delegate?.didCreateNewItem()
    }

    func didTapSaveButton(item: TodoItem) {
        manager.updateItem(item: item) { result in
            switch result {
            case .success(let success):
                debugPrint(success ? "success" : "failure")
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }

    func deleteItem(itemId: UUID) {
        manager.deleteItem(itemId: itemId) { result in
            switch result {
            case .success(let success):
                debugPrint(success ? "success" : "failure")
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
}
