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
}

class CoreDataManager: CoreDataProtocol {
    
    private lazy var context = persistentContainer.viewContext
    
    //MARK: - Public
    func getAllItems(result: @escaping (Result<[TodoItem], CoreDataError>) -> Void) {
        var items = [TodoItem]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TodoListItem")
        do{
            let results = try context.fetch(fetchRequest)
            results.forEach { result in
                let item = createItemFromNSManagedObject(object: result as! NSManagedObject)
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
        
        newItem.setValue(item.id, forKey: "id")
        newItem.setValue(item.title, forKey: "title")
        newItem.setValue(item.detail, forKey: "detail")
        newItem.setValue(item.startDate, forKey: "startDate")
        newItem.setValue(item.endDate, forKey: "endDate")
        
        result(.success(true))
    }
    
    
    
    //MARK: - Private
    private func createItemFromNSManagedObject(object: NSManagedObject) -> TodoItem {
        let id = object.value(forKey: "id") as! UUID
        let title = object.value(forKey: "title") as! String
        let detail = object.value(forKey: "detail") as? String
        let startDate = object.value(forKey: "startDate") as! Date
        let endDate = object.value(forKey: "endDate") as! Date
        
        return TodoItem(id: id, title: title, detail: detail, startDate: startDate, endDate: endDate)
    }
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TodoApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    private func saveContext () {
        //let context = persistentContainer.viewContext
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

