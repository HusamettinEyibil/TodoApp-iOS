//
//  CoreDataError.swift
//  GetirTodo
//
//  Created by Hüsamettin  Eyibil on 20.03.2022.
//

import Foundation

enum CoreDataError: Error {
    case failedToGetData
    case failedToCreateNewItem
    case failedToUpdateData
    case failedToDelete
}
