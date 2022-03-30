//
//  TodoListViewModel.swift
//  GetirTodo
//
//  Created by Hüsamettin  Eyibil on 20.03.2022.
//

import Foundation

protocol TodoListViewModelDelegate: NSObject {
    func didFetchItems(_ output: TodoListViewModelOutput)
    func navigate(to route: TodoListViewRoute)
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
        manager.createNewItem(item: TodoItem(title: "Husam", detail: "Naber")) { result in
            switch result {
            case .success(_):
                break
            case .failure(_):
                break
            }
        }
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
    
    func didSelectRow(at indexPath: IndexPath) {
        let item = items[indexPath.row]
        self.delegate?.navigate(to: .showDetail(item: item))
    }
    
    func didTapAddButton() {
        let emptyItem = TodoItem(title: "", detail: "")
        self.delegate?.navigate(to: .addNewItem(item: emptyItem))
    }
}
