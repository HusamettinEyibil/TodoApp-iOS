//
//  TodoItem.swift
//  GetirTodo
//
//  Created by Hüsamettin  Eyibil on 20.03.2022.
//

import Foundation

struct TodoItem {
    var id: UUID
    var title: String
    var detail: String?
    var startDate: Date
    var endDate: Date
}
