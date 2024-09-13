//
//  TaskTypeSelectorView.swift
//  ToDo
//
//  Created by Данила Бондарь on 13.09.2024.
//

import Foundation
import UIKit

class TaskTypeSelectorView: UIView{
    convenience init(){
        self.init(frame: .zero)
        self.backgroundColor = .systemGray6
    
        let allTasksLabel = BadgeLabelView()
        allTasksLabel.labelText = "Все"
        allTasksLabel.badgeCount = 1
        self.addSubview(allTasksLabel)
        allTasksLabel.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().offset(16)
            maker.top.bottom.equalToSuperview()
            maker.width.equalToSuperview().multipliedBy(0.19)
        }
        
        let separator = UIView()
        self.addSubview(separator)
        separator.backgroundColor = .systemGray5
        separator.layer.cornerRadius = 3
        separator.snp.makeConstraints { maker in
            maker.top.bottom.equalToSuperview().inset(10)
            maker.leading.equalTo(allTasksLabel.snp.trailing)
            maker.width.equalTo(3)
        }
        
        let closedTasksLabel = BadgeLabelView()
        closedTasksLabel.labelText = "Готовые"
        closedTasksLabel.badgeCount = 1
        self.addSubview(closedTasksLabel)
        closedTasksLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(separator.snp.trailing).offset(15)
            maker.top.bottom.equalToSuperview()
            maker.width.equalToSuperview().multipliedBy(0.27)
        }
        
        let openTasksLabel = BadgeLabelView()
        openTasksLabel.labelText = "Завершенные"
        openTasksLabel.badgeCount = 1
        self.addSubview(openTasksLabel)
        openTasksLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(closedTasksLabel.snp.trailing).offset(15)
            maker.top.bottom.equalToSuperview()
            maker.width.equalToSuperview().multipliedBy(0.4)
        }
    }
}
