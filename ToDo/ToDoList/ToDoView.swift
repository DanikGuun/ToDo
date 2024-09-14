//
//  ToDoView.swift
//  ToDo
//
//  Created by Данила Бондарь on 13.09.2024.
//

import UIKit

class ToDoView: UIView, TaskTypeSelectorDelegate {

    private var taskTypeStack = TaskTypeSelectorView()
    private var allTableView = UITableView()
    private var openTableView = UITableView()
    private var closedTableView = UITableView()
    private var selectedType: TaskType = .all
    
    //MARK: - Initialize
    convenience init(){
        self.init(frame: .zero)
        setup()
    }
    
    private func setup(){
        //Task Type Selector
        self.addSubview(taskTypeStack)
        taskTypeStack.delegate = self
        taskTypeStack.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview()
            maker.top.equalToSuperview()
            maker.height.equalToSuperview().dividedBy(17)
        }
        //All Tasks CollectionView
        self.addSubview(allTableView)
        allTableView.backgroundColor = .red
        allTableView.snp.makeConstraints { maker in
            maker.leading.trailing.bottom.equalToSuperview()
            maker.top.equalTo(taskTypeStack.snp.bottom).offset(10)
        }
        
    }
    
    //MARK: - All Tasks Table
    
    //MARK: - Task Type Delegate
    func selectType(_ type: TaskType) {
        UIView.animate(withDuration: 1, delay: 0, animations: {
            self.setNeedsLayout()
            self.allTableView.snp.updateConstraints { maker in
                maker.leading.equalToSuperview().inset(50)
            }
            self.layoutIfNeeded()
        })
    }
}

