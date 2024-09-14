//
//  TodoTask+CoreDataProperties.swift
//  ToDo
//
//  Created by Данила Бондарь on 14.09.2024.
//
//

import Foundation
import CoreData


extension TodoTask {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoTask> {
        return NSFetchRequest<TodoTask>(entityName: "TodoTask")
    }

    @NSManaged public var desription: String?
    @NSManaged public var endDate: Date?
    @NSManaged public var isDone: Bool
    @NSManaged public var name: String?
    @NSManaged public var startDate: Date?

}

extension TodoTask : Identifiable {

}
