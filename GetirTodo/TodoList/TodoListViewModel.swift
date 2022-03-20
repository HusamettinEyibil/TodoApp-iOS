//
//  TodoListViewModel.swift
//  GetirTodo
//
//  Created by Hüsamettin  Eyibil on 20.03.2022.
//

import Foundation

protocol TodoListViewModelDelegate: NSObject {
    func didFetchItems(_ output: TodoListViewModelOutput)
}

enum TodoListViewModelOutput {
    case showItemList([TodoListPresentation])
}

class TodoListViewModel: TodoListViewModelProtocol {
    weak var delegate: TodoListViewModelDelegate?
    
    private let manager: CoreDataProtocol!
    private var items = [TodoItem]()
    
    init(manager: CoreDataProtocol) {
        self.manager = manager
    }
    
    func viewDidLoad() {
        fetchItems()
    }
    
    private func fetchItems() {
        manager.getAllItems { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let items):
                self.items = items
                self.delegate?.didFetchItems(.showItemList(items.map { item in
                    return TodoListPresentation(title: item.title)
                }))
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
}
