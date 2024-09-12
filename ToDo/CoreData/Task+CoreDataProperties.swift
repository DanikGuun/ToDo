//
//  Task+CoreDataProperties.swift
//  ToDo
//
//  Created by Данила Бондарь on 12.09.2024.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var name: String?
    @NSManaged public var desription: String?
    @NSManaged public var startDate: Date?
    @NSManaged public var endDate: Date?
    @NSManaged public var isDone: Bool
}

extension Task : Identifiable {

}
