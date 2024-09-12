//
//  Task+CoreDataClass.swift
//  ToDo
//
//  Created by Данила Бондарь on 12.09.2024.
//
//

import Foundation
import CoreData

@objc(Task)
public class Task: NSManagedObject {
    
    init(name: String, description: String, startDate: Date, endDate: Date, isDone: Bool){
        let entityDescription = NSEntityDescription.entity(forEntityName: "Task", in: CDManager.context)!
        super.init(entity: entityDescription, insertInto: CDManager.context)
        self.name = name
        self.desription = description
        self.startDate = startDate
        self.endDate = endDate
        self.isDone = isDone
    }
}
