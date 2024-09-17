//
//  ToDoView.swift
//  ToDo
//
//  Created by Данила Бондарь on 13.09.2024.
//

import UIKit
import CoreData

class ToDoView: UIView, TaskTypeSelectorDelegate, NSFetchedResultsControllerDelegate {

    private var taskTypeStack = TaskTypeSelectorView()
    private var tasksTableView = UITableView(frame: .zero, style: .insetGrouped)
    private var selectedType: TaskType = .all
    private lazy var fetchResultController: NSFetchedResultsController<TodoTask> = {
        let request = TodoTask.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "objectID", ascending: true)]
        let controller = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CDManager.context, sectionNameKeyPath: "objectID", cacheName: nil)
        controller.delegate = self
        return controller
    }()
    
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
        //All Tasks Table View
        self.addSubview(tasksTableView)
        tasksTableView.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview()
            maker.top.equalTo(taskTypeStack.snp.bottom).offset(10)
            maker.bottom.equalTo(keyboardLayoutGuide.snp.top)
        }
        tasksTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tasksTableView.allowsSelection = false
        tasksTableView.rowHeight = UIScreen.main.bounds.height/7
        tasksTableView.backgroundColor = .clear
        AppData.tasksDataSource = UITableViewDiffableDataSource<UUID, NSManagedObjectID>(tableView: tasksTableView, cellProvider: {(table, indexPath, id) in
            let cell = table.dequeueReusableCell(withIdentifier: "cell")
            if let item = try? CDManager.context.existingObject(with: id) as? TodoTask{
                var conf = TaskCellConfiguration()
                conf.name = item.name!
                conf.isDone = item.isDone
                cell?.contentConfiguration = conf
            }
            return cell
            }
        )
        try! fetchResultController.performFetch()
    }
    
    //MARK: - All Tasks Table
    func controller(_ controller: NSFetchedResultsController<any NSFetchRequestResult>, didChangeContentWith snapshot: NSDiffableDataSourceSnapshotReference) {
        AppData.tasksDataSource?.apply(snapshot as NSDiffableDataSourceSnapshot<UUID, NSManagedObjectID>)
    }
    
    
    //MARK: - Task Type Delegate
    func selectType(_ type: TaskType) {

    }
}

