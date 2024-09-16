//
//  TaskCellConfiguration.swift
//  ToDo
//
//  Created by Данила Бондарь on 16.09.2024.
//

import Foundation
import UIKit

struct TaskCellConfiguration: UIContentConfiguration{
    
    var name: String = "Задание..."
    var description: String = "Описание"
    var startDate: Date = Date()
    var endDate: Date = Date()
    var isDone: Bool = false
    
    func makeContentView() -> any UIView & UIContentView {
        return TaskCellContentView(configuration: self)
    }
    
    func updated(for state: any UIConfigurationState) -> TaskCellConfiguration {
        return self
    }
    
    
}
