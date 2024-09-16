//
//  Model.swift
//  ToDo
//
//  Created by Данила Бондарь on 14.09.2024.
//

import Foundation
import UIKit
import CoreData

var AppData = Model()

class Model{
    fileprivate init(){}
    
    var tasksDataSource: UITableViewDiffableDataSource<UUID, NSManagedObjectID>?
}
