//
//  ToDoView.swift
//  ToDo
//
//  Created by Данила Бондарь on 13.09.2024.
//

import UIKit
import CoreData

class ToDoView: UIView, TaskTypeSelectorDelegate, NSFetchedResultsControllerDelegate, UITableViewDelegate {

    var taskTypeStack = TaskTypeSelectorView()
    private var tasksTableView = UITableView(frame: .zero, style: .insetGrouped)
    private var selectedType: TaskType = .all
    private lazy var fetchResultController: NSFetchedResultsController<TodoTask> = {
        let dateSort = NSSortDescriptor(key: "startDate", ascending: false)
        let isDoneSort = NSSortDescriptor(key: "isDone", ascending: true)
        let request = TodoTask.fetchRequest()
        request.sortDescriptors = [isDoneSort, dateSort]
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
        tasksTableView.register(TaskCell.self, forCellReuseIdentifier: "cell")
        tasksTableView.allowsSelection = false
        tasksTableView.rowHeight = UIScreen.main.bounds.height/7
        tasksTableView.backgroundColor = .clear
        tasksTableView.showsVerticalScrollIndicator = false
        tasksTableView.delegate = self
        AppData.tasksDataSource = UITableViewDiffableDataSource<UUID, NSManagedObjectID>(tableView: tasksTableView, cellProvider: {(table, indexPath, id) in
            let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            if let item = try? CDManager.context.existingObject(with: id) as? TodoTask{
                var conf = TaskCellConfiguration()
                conf.name = item.name!
                conf.description = item.desription ?? ""
                conf.isDone = item.isDone
                conf.startDate = item.startDate ?? Date()
                conf.endDate = item.endDate ?? Date()
                conf.item = item
                cell.contentConfiguration = conf
            }
            return cell
            }
        )
        tasksTableView.keyboardDismissMode = .onDrag
        try! fetchResultController.performFetch()
    }
    
    //MARK: - All Tasks Table
    func controller(_ controller: NSFetchedResultsController<any NSFetchRequestResult>, didChangeContentWith snapshot: NSDiffableDataSourceSnapshotReference) {
        AppData.tasksDataSource?.apply(snapshot as NSDiffableDataSourceSnapshot<UUID, NSManagedObjectID>, animatingDifferences: true)
        
        //Updating Categories Badge Labels
        let request = TodoTask.fetchRequest()
        request.predicate = NSPredicate(format: "isDone = false")
        let openTasksCount = (try? CDManager.context.count(for: request)) ?? 0
        request.predicate = NSPredicate(format: "isDone = true")
        let closedTasksCount = (try? CDManager.context.count(for: request)) ?? 0
        
        taskTypeStack.setBadgeForType(openTasksCount + closedTasksCount, for: .all)
        taskTypeStack.setBadgeForType(openTasksCount, for: .open)
        taskTypeStack.setBadgeForType(closedTasksCount, for: .closed)
    }
    
    //MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let act = UIContextualAction(style: .destructive, title: "Удалить", handler: { (action, view, allow) in
            
            guard let cell = tableView.cellForRow(at: indexPath) as? TaskCell,
                  let conf = cell.contentConfiguration as? TaskCellConfiguration,
                  let item = conf.item
            else { allow(false); return }
            CDManager.context.delete(item)
            
            allow(true)
        })
        act.image = UIImage(systemName: "trash")
        return UISwipeActionsConfiguration(actions: [act])
    }
    
    //MARK: - Task Type Delegate
    func selectType(_ type: TaskType) {
        switch type {
        case .all:
            fetchResultController.fetchRequest.predicate = nil
        case .open:
            fetchResultController.fetchRequest.predicate = NSPredicate(format: "isDone = false")
        case .closed:
            fetchResultController.fetchRequest.predicate = NSPredicate(format: "isDone = true")
        }
        try? fetchResultController.performFetch()
    }
    
}

