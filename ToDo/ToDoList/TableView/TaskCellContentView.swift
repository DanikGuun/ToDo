//
//  TaskCellContentView.swift
//  ToDo
//
//  Created by Данила Бондарь on 16.09.2024.
//

import Foundation
import UIKit
import SnapKit

class TaskCellContentView: UIView, UIContentView{
    
    var configuration: any UIContentConfiguration
    var nameField = UITextField()
    var descriptionField = UITextField()
    
    //MARK: - Initialize
    init(configuration conf: TaskCellConfiguration) {
        self.configuration = conf
        super.init(frame: .zero)
        
        self.addSubview(nameField)
        nameField.text = conf.name
        nameField.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
