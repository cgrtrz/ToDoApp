//
//  DataManager.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 14/12/2024.
//

import Foundation

@MainActor
final class DataManager: ObservableObject {
    
    ///Dependency Injection
    ///
    ///`repository` calls `getTaskRepository()` method from `RepositoryManager` singleton where data soures are set.
    private let repository = RepositoryManager.shared.getToDoRepository()
    private var toDoListType: ToDoListType = .all
    private var type: ToDoListType = .all
    @Published var toDos: [ToDo] = []
    @Published var isLoading: Bool = false
    
    init(){
        Task {
            getToDos(.all)
        }
    }
    
    func getToDos(_ type: ToDoListType) {
        print("fethcing begins")
        toDos = []
        self.type = type
        Task {
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
                print("fethcing inprogress")
                isLoading = false

            } catch {
                print(error)
            }
        }
        print("fethcing ends")
            }
    
    func addToDo(_ toDo: ToDo) {
        Task {
            try await repository.addToDo(toDo)
            getToDos(type)
        }
    }
    
    func updateToDo(_ toDo: ToDo) {
        Task {
            try await repository.updateToDo(toDo)
            getToDos(type)
        }
    }
    
    func deleteToDo(_ toDo: ToDo) {
        Task {
            try await repository.deleteToDo(toDo)
            getToDos(type)
        }
    }
}
