
import Foundation
import UIKit
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: из AppDelegate NSPersistentContainer
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "HW_4_ToDo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: из AppDelegate saveContext
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: извлекаем даннные (универсальная функция)
    func fetchTasksUniversal(statusFetch: Bool, statusPredicate: Bool) -> [Tasks] {
        
        let fetchRequest : NSFetchRequest<Tasks> = Tasks.fetchRequest()
        
        switch statusFetch { /// true-_ = все данные, false-true - созданные, false-false - кроме созданных
        case true: /// извлекаем все (true-_)
            print("извлекаем все данные")
        case false:
            switch statusPredicate {
            case true: /// извлекаем только созданные (false-true)
                let predicate = NSPredicate(format: "status = %@", "создана")
                fetchRequest.predicate = predicate
            case false: /// извлекаем кроме созданных (false-false)
                let predicate = NSPredicate(format: "status != %@", "создана")
                fetchRequest.predicate = predicate
            }
        }
        
        do {
            return try context.fetch(fetchRequest)
        } catch let error {
            print(error)
            return []
        }
    }
    
    // MARK: сохранение новой задачи
    func saveNewTask(head: String, body: String, dateTask: String, deadline: String, status: String) {
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Tasks", in: context) else {return}
        
        let tasks = Tasks(entity: entity, insertInto: context)
        
        tasks.head = head
        tasks.body = body
        tasks.dateTask = dateTask
        tasks.deadline = deadline
        tasks.status = status
        
        saveContext()
        
    }
    
    // MARK: редактирование задачи
    func editTask(head: String, body: String, dateTask: String, deadline: String, status: String) {
        saveContext()
        do {
            try! context.save()
        }
    }
    
    // MARK: редактирование только статуса задачи
    func editTaskOnlyStatus(status: String) {
        saveContext()
        do {
            try! context.save()
        }
    }
    
    // MARK: удалить строку
    func deleteTask(task: Tasks) {
        context.delete(task)
        saveContext()
    }
}
