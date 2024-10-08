//
//  ViewController.swift
//  ToDo
//
//  Created by Данила Бондарь on 11.09.2024.
//

import UIKit
import SnapKit

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
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
        todayDateLabel.text = Date().formatted(.dateTime.weekday(.wide).day().month(.wide).locale(Locale(identifier: "ru_RU")))
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
        addTaskButton.addAction(UIAction(handler: { _ in
            CDManager.addTask(name: "", descritption: "", startDate: Date(), endDate: Date(), isDone: false)
        }), for: .touchUpInside)
        
        //ToDo view
        let todoView = ToDoView()
        self.view.addSubview(todoView)
        todoView.snp.makeConstraints { maker in
            maker.leading.trailing.bottom.equalToSuperview()
            maker.top.equalTo(todayDateLabel.snp.bottom).offset(15)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var sourceView = UIView()
        
        if let controller = segue.destination as? TimePickerViewController{
            if let (delegateView, startTime, minTime) = sender as? (any TimePickerViewDelegate, DateComponents, DateComponents?){
                sourceView = delegateView as! UIView
                controller.delegate = delegateView
                controller.startTime = startTime
                controller.minTime = minTime
            }
        }
        
        else if let controller = segue.destination as? DatePickerController{
            if let (delegateView, startDate) = sender as? (any DatePickerDelegate, Date){
                sourceView = delegateView as! UIView
                controller.delegate = delegateView
                controller.startDate = startDate
            }
        }
        
        if let presentController = segue.destination.popoverPresentationController{
            presentController.delegate = self
            presentController.sourceView = sourceView
            presentController.permittedArrowDirections = [.up, .down]
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        .none
    }
}

