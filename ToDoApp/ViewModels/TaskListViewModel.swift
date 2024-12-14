//
//  TaskListViewModel.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 06/12/2024.
//

import Foundation
import SwiftUI

enum TaskListType : Int{
    case all = 0
    case active = 1
    case completed = 2
}

@MainActor
final class TaskListViewModel : ObservableObject {
    
    @Published var tasks: [ToDoTask_] = []
    @Published var isLoading: Bool = false
    
    //let repository : TaskRepository
    var taskListType: TaskListType = .all
    
    let repository = RepositoryManager.shared.getTaskRepository()
    
    
    init(){
        Task {
            await getTasks(.all)
        }
    }
    
    
    
    func getTasks(_ type: TaskListType) async {
        isLoading = true
        do {
            tasks = try await repository.getTasks(type: type) as! [ToDoTask_]
            switch type {
            case .active:
                tasks = tasks.filter({ $0.isCompleted == false })
            case .completed:
                tasks =  tasks.filter({ $0.isCompleted == true })
            case .all:
                tasks =  tasks.filter({ $0.isCompleted == false }) + tasks.filter({ $0.isCompleted == true })
            }
        } catch {
            print(error)
        }
        isLoading = false
    }
        
    func addTask(_ task: ToDoTask_)async throws -> Void {
        try await repository.addTask(task)
    }
    
    func updateTask(_ task: ToDoTask_)async throws -> Void {
       try await repository.updateTask(task)
    }
    
    func deleteTask(_ task: ToDoTask_)async throws -> Void {
        try await repository.deleteTask(task)
    }
}
