//
//  ViewController.swift
//  ToDo
//
//  Created by Данила Бондарь on 11.09.2024.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup(){
        self.view.backgroundColor = .background
        //Today Tasks Label
        let todayTasksLabel = UILabel()
        self.view.addSubview(todayTasksLabel)
        todayTasksLabel.text = "Задачи на сегодня"
        todayTasksLabel.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        todayTasksLabel.snp.makeConstraints { maker in
            maker.top.equalTo(view.safeAreaLayoutGuide)
            maker.leading.equalTo(view.safeAreaLayoutGuide).inset(15)
        }
        //Today Date Label
        let todayDateLabel = UILabel()
        self.view.addSubview(todayDateLabel)
        todayDateLabel.text = Date().formatted(.dateTime.weekday(.wide).day().month(.wide))
        todayDateLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        todayDateLabel.textColor = .secondaryLabel
        todayDateLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(todayTasksLabel.snp.leading)
            maker.top.equalTo(todayTasksLabel.snp.bottom).offset(5)
        }
        //Add Task Button
        let addTaskButton = UIButton(configuration: .tinted())
        self.view.addSubview(addTaskButton)
        var conf = addTaskButton.configuration
        var attributedTitle = AttributedString(stringLiteral: "Задача")
        attributedTitle.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        conf?.attributedTitle = attributedTitle
        conf?.cornerStyle = .large
        conf?.image = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 14, weight: .semibold, scale: .medium))
        conf?.imagePadding = 5
        conf?.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        addTaskButton.configuration = conf
        
        addTaskButton.snp.makeConstraints { maker in
            maker.trailing.equalToSuperview().inset(15)
            maker.centerY.equalTo(todayTasksLabel.snp.bottom)
        }
    }

}

