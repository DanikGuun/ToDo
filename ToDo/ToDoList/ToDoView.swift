//
//  ToDoView.swift
//  ToDo
//
//  Created by Данила Бондарь on 13.09.2024.
//

import UIKit

class ToDoView: UIView {

    private var taskTypeStack: TaskTypeSelectorView!
    
    //MARK: - Initialize
    convenience init(){
        self.init(frame: .zero)
        setup()
    }
    
    private func setup(){
        //Task Type Selector
        taskTypeStack = TaskTypeSelectorView()
        self.addSubview(taskTypeStack)
        taskTypeStack.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview()
            maker.top.equalToSuperview()
            maker.height.equalToSuperview().dividedBy(17)
        }
    }
    
}

