//
//  CoreDataManager.swift
//  ToDo
//
//  Created by Данила Бондарь on 12.09.2024.
//

import Foundation
import CoreData

var CDManager = CoreDataManager()

class CoreDataManager{
    fileprivate init(){}
    
    var persistentContainer: NSPersistentContainer {
        let container = NSPersistentContainer(name: "ToSo")
        container.loadPersistentStores(completionHandler: {(description, error) in
            if let error = error{
                fatalError(error.localizedDescription)
            }
        })
        return container
    }
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
