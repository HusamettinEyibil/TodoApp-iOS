//
//  CoreDataManager.swift
//  GetirTodo
//
//  Created by Hüsamettin  Eyibil on 20.03.2022.
//

import Foundation
import CoreData

protocol CoreDataProtocol {
    func getAllItems(result: @escaping (Result<[TodoItem], CoreDataError>) -> Void)
    func createNewItem(item: TodoItem, result: @escaping (Result<Bool, CoreDataError>) -> Void)
    func updateItem(item: TodoItem, result: @escaping (Result<Bool, CoreDataError>) -> Void)
    func deleteItem(itemId: UUID, result: @escaping (Result<Bool, CoreDataError>) -> Void)
}

class CoreDataManager: CoreDataProtocol {

    private lazy var context = persistentContainer.viewContext

    // MARK: - Public
    func getAllItems(result: @escaping (Result<[TodoItem], CoreDataError>) -> Void) {
        var items = [TodoItem]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TodoListItem")
        do {
            let results = try context.fetch(fetchRequest)
            results.forEach { result in
                guard let result = result as? NSManagedObject else {return}
                let item = createItemFromNSManagedObject(object: result)
                items.append(item)
            }
            result(.success(items))
        } catch {
            result(.failure(.failedToGetData))
        }
    }

    func createNewItem(item: TodoItem, result: @escaping (Result<Bool, CoreDataError>) -> Void) {
        guard let entity = NSEntityDescription.entity(forEntityName: "TodoListItem", in: context) else {
            result(.failure(.failedToCreateNewItem))
            return
        }

        let newItem = NSManagedObject(entity: entity, insertInto: context)

        newItem.setValue(item.itemId!, forKey: "itemId")
        newItem.setValue(item.title, forKey: "title")
        newItem.setValue(item.detail, forKey: "detail")
        saveContext()
        result(.success(true))
    }

    func updateItem(item: TodoItem, result: @escaping (Result<Bool, CoreDataError>) -> Void) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TodoListItem")
        do {
            let results = try context.fetch(fetchRequest)
            guard let itemToUpdate = results.filter({ result in
                guard let itemId = item.itemId else {return false}
                guard let result = result as? NSManagedObject,
                      let id = result.value(forKey: "itemId") as? UUID else {
                    return false
                }
                return id == itemId
            }).first as? NSManagedObject else {
                return
            }

            itemToUpdate.setValue(item.title, forKey: "title")
            itemToUpdate.setValue(item.detail, forKey: "detail")
            saveContext()
            result(.success(true))
        } catch {
            result(.failure(.failedToUpdateData))
        }
    }

    func deleteItem(itemId: UUID, result: @escaping (Result<Bool, CoreDataError>) -> Void) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TodoListItem")
        do {
            let results = try context.fetch(fetchRequest)
            guard let itemToDelete = results.filter({ result in
                guard let result = result as? NSManagedObject,
                      let id = result.value(forKey: "itemId") as? UUID else {
                    return false
                }
                return id == itemId
            }).first as? NSManagedObject else {
                return
            }
            context.delete(itemToDelete)
            saveContext()
            result(.success(true))
        } catch {
            result(.failure(.failedToDelete))
        }
    }

    // MARK: - Private
    private func createItemFromNSManagedObject(object: NSManagedObject) -> TodoItem {
        guard let itemId = object.value(forKey: "itemId") as? UUID,
              let title = object.value(forKey: "title") as? String,
              let detail = object.value(forKey: "detail") as? String else {
            return TodoItem(title: "", detail: "")
        }

        return TodoItem(itemId: itemId, title: title, detail: detail)
    }

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TodoApp")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    private func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
