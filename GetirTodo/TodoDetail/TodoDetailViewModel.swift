//
//  TodoDetailViewModel.swift
//  GetirTodo
//
//  Created by Hüsamettin  Eyibil on 22.03.2022.
//

import Foundation

protocol TodoDetailViewModelDelegate: NSObject {
    func showDetail(item: TodoItem)
}

class TodoDetailViewModel: TodoDetailViewModelProtocol {
    weak var delegate: TodoDetailViewModelDelegate?
    
    private let item: TodoItem
    
    init(item: TodoItem) {
        self.item = item
    }
    
    func viewDidLoad() {
        delegate?.showDetail(item: item)
    }
}
