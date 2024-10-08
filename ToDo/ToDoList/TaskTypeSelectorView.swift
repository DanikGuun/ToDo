//
//  TaskTypeSelectorView.swift
//  ToDo
//
//  Created by Данила Бондарь on 13.09.2024.
//

import Foundation
import UIKit

class TaskTypeSelectorView: UIView{
    
    var delegate: TaskTypeSelectorDelegate?
    private var labels: [BadgeLabelView] = []
    private let allTasksLabel = BadgeLabelView()
    private let closedTasksLabel = BadgeLabelView()
    private let openTasksLabel = BadgeLabelView()
    
    convenience init(){
        self.init(frame: .zero)
    
        
        self.addSubview(allTasksLabel)
        allTasksLabel.labelText = "Все"
        allTasksLabel.badgeCount = 1
        allTasksLabel.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().offset(16)
            maker.top.bottom.equalToSuperview()
            maker.width.equalToSuperview().multipliedBy(0.19)
        }
        labels.append(allTasksLabel)
        allTasksLabel.addAction(UIAction(handler: { self.typeSelected(action: $0, type: .all) }), for: .touchUpInside)
        allTasksLabel.isSelected = true
        
        let separator = UIView()
        self.addSubview(separator)
        separator.backgroundColor = .systemGray5
        separator.layer.cornerRadius = 3
        separator.snp.makeConstraints { maker in
            maker.top.bottom.equalToSuperview().inset(10)
            maker.leading.equalTo(allTasksLabel.snp.trailing)
            maker.width.equalTo(3)
        }
        
        self.addSubview(openTasksLabel)
        openTasksLabel.labelText = "Сделать"
        openTasksLabel.badgeCount = 1
        openTasksLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(separator.snp.trailing).offset(15)
            maker.top.bottom.equalToSuperview()
            maker.width.equalToSuperview().multipliedBy(0.27)

        }
        labels.append(openTasksLabel)
        openTasksLabel.addAction(UIAction(handler: { self.typeSelected(action: $0, type: .open) }), for: .touchUpInside)
        
        self.addSubview(closedTasksLabel)
        closedTasksLabel.labelText = "Готовые"
        closedTasksLabel.badgeCount = 1
        closedTasksLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(openTasksLabel.snp.trailing).offset(15)
            maker.top.bottom.equalToSuperview()
            maker.width.equalToSuperview().multipliedBy(0.4)
        }
        labels.append(closedTasksLabel)
        closedTasksLabel.addAction(UIAction(handler: { self.typeSelected(action: $0, type: .closed) }), for: .touchUpInside)
        

    }
    
    func setBadgeForType(_ count: Int, for type: TaskType){
        switch type {
        case .all:
            allTasksLabel.badgeCount = count
        case .open:
            openTasksLabel.badgeCount = count
        case .closed:
            closedTasksLabel.badgeCount = count
        }
    }
    
    private func typeSelected(action: UIAction, type: TaskType){
        labels.forEach { $0.isSelected = $0 == (action.sender as! BadgeLabelView) }
        delegate?.selectType(type)
    }
}

enum TaskType: Int{
    case all = 0
    case open = 1
    case closed = 2
}

protocol TaskTypeSelectorDelegate{
    func selectType(_ type: TaskType)
}
