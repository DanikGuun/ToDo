//
//  TaskCell.swift
//  ToDo
//
//  Created by Данила Бондарь on 18.09.2024.
//

import UIKit

class TaskCell: UITableViewCell {
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        guard let conf = self.contentConfiguration as? TaskCellConfiguration else { return }
        guard let contentView = self.contentView as? TaskCellContentView else { return }
        contentView.updateConfiguration(conf)
    }

}
