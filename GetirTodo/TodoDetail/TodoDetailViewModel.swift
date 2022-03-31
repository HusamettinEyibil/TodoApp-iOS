//
//  TodoDetailViewModel.swift
//  GetirTodo
//
//  Created by Hüsamettin  Eyibil on 22.03.2022.
//

import Foundation

protocol TodoDetailViewModelDelegate: NSObject {
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
            case .success(_):
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        delegate?.didCreateNewItem()
    }
    
    func didTapSaveButton(item: TodoItem) {
        manager.updateItem(item: item) { result in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
