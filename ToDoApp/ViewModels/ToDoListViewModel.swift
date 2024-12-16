//
//  TaskListViewModel.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 06/12/2024.
//

import Foundation
import SwiftUI

enum ToDoListType : Int, CaseIterable {
    case all = 0
    case active = 1
    case completed = 2
    
    var name: String {
        switch self {
        case .all: return "All"
        case .active: return "Active"
        case .completed: return "Completed"
        }
    }
}

@MainActor
final class ToDoListViewModel : ObservableObject {
    
    @Published var toDos: [ToDo] = []
    @Published var isLoading: Bool = false
    
    //let repository : TaskRepository
    var toDoListType: ToDoListType = .all
    
    let repository = RepositoryManager.shared.getToDoRepository()
    
    
    init(){
        Task {
            await getToDos(.all)
        }
    }
    
    
    
    func getToDos(_ type: ToDoListType) async {
        isLoading = true
        do {
            toDos = try await repository.getToDos(type: type)
            switch type {
            case .active:
                toDos = toDos.filter({ $0.isCompleted == false })
            case .completed:
                toDos =  toDos.filter({ $0.isCompleted == true })
            case .all:
                toDos =  toDos.filter({ $0.isCompleted == false }) + toDos.filter({ $0.isCompleted == true })
            }
        } catch {
            print(error)
        }
        isLoading = false
    }
        
    func addToDo(_ toDo: ToDo)async throws -> Void {
        try await repository.addToDo(toDo)
    }
    
    func updateToDo(_ toDo: ToDo)async throws -> Void {
        try await repository.updateToDo(toDo)
    }
    
    func deleteTask(_ toDo: ToDo)async throws -> Void {
        try await repository.deleteToDo(toDo)
        //repository.getTasks(type: <#T##TaskListType#>)
    }
}
