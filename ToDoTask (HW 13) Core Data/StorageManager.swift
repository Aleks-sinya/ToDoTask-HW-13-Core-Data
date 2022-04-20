//
//  StorageManager.swift
//  ToDoTask (HW 13) Core Data
//
//  Created by Алексей Синяговский on 19.04.2022.
//


import CoreData

class StorageManager {
    
    static let shared = StorageManager()
    
    let viewContext = PersistentContainer.shared.viewContext
    
    // MARK: – Save methods
    func save(_ taskName: String) {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "Task", in: viewContext) else { return }
        guard let task = NSManagedObject(entity: entityDescription, insertInto: viewContext) as? Task else { return }
        task.title = taskName
        
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK: – Fetch Data
    func fetchData(tasks: inout [Task]) {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        
        do {
            tasks = try viewContext.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK: – Delete Data
    func deleteData(_ indexPath: IndexPath) {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        
        if let taskList = try? viewContext.fetch(fetchRequest) {
            viewContext.delete(taskList[indexPath.row])
        }
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK: – Insert Data
    private func insertData(_ indexPath: IndexPath) {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        
        if let taskList = try? viewContext.fetch(fetchRequest) {
            viewContext.insert(taskList[indexPath.row])
        }
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    /*
    // MARK: - Core Data stack
    var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "ToDoTask__HW_13__Core_Data")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    */
    private init() {}
}
