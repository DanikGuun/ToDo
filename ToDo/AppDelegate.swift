//
//  AppDelegate.swift
//  ToDo
//
//  Created by Данила Бондарь on 11.09.2024.
//

import UIKit
import CoreData
import Foundation

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //добавляем стартовые операции, если их еще нет
        print(UserDefaults.standard.bool(forKey: "isInitialTaskLoaded"))
        if UserDefaults.standard.bool(forKey: "isInitialTaskLoaded") == false{
            Task(priority: .high, operation: {
                let stringURL = Bundle.main.path(forResource: "initialTasks", ofType: "json")!
                let url = URL(filePath: stringURL)
                guard let data = try? Data(contentsOf: url) else { return }
                guard let tasks = try? JSONDecoder().decode(InitialTodos.self, from: data) else { return }
                tasks.todos.forEach{
                    CDManager.addTask(name: $0.todo, descritption: "", startDate: Date(), endDate: Date(), isDone: $0.completed)
                }
            })
            UserDefaults.standard.setValue(true, forKey: "isInitialTaskLoaded")
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}


fileprivate struct InitialTodos: Codable{
    let todos: [InitialTask]
}
fileprivate struct InitialTask: Codable{
    let todo: String
    let completed: Bool
}

