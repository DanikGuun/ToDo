//
//  Model.swift
//  ToDo
//
//  Created by Данила Бондарь on 14.09.2024.
//

import Foundation
import UIKit

var AppData = Model()

class Model{
    fileprivate init(){}
    
    var allTasksDataSource: UITableViewDiffableDataSource<UUID, UUID>?
}
