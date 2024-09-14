//
//  TodoTask+CoreDataClass.swift
//  ToDo
//
//  Created by Данила Бондарь on 14.09.2024.
//
//

import Foundation
import CoreData

@objc(TodoTask)
public class TodoTask: NSManagedObject {
    
    convenience init(name: String, description: String, startDate: Date, endDate: Date, isDone: Bool){
        let entityDescription = NSEntityDescription.entity(forEntityName: "TodoTask", in: CDManager.context)!
        self.init(entity: entityDescription, insertInto: CDManager.context)
        self.name = name
        self.desription = description
        self.startDate = startDate
        self.endDate = endDate
        self.isDone = isDone
    }
}
