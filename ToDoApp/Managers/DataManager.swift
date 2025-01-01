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
    private var toDos: [ToDo] = []
    
    
    @Published var isLoading: Bool = false
    @Published var message = ""
    @Published var showingMessage = false {
        didSet {
            if showingMessage == true {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.showingMessage = false
                }
            }
        }
    }
    @Published var toDosCache: [ToDo] = [] //ToDos that view shows.
    {
        didSet {
            print("something changed... \(toDosCache.count)")
        }
    }
    
    init(){
        Task {
            self.getToDos()
        }
    }

    func getToDos() {
        isLoading = true
        toDos = []
        Task {
            do {
                toDos = try await repository.getToDos()
                toDos.sort(by: { $0.creationDate > $1.creationDate })
                toDos.sort(by: { !$0.isCompleted && $1.isCompleted })
                toDosCache = toDos
                isLoading = false
            } catch {
                print(error)
            }
        }
    }

    func addToDo(_ toDo: ToDo) {
        Task {
            try await repository.addToDo(toDo)
            getToDos()
            message = "New ToDo added: \(toDo.title)"
            showingMessage = true
        }
    }
    
    func updateToDo(_ toDo: ToDo) {
        Task {
            try await repository.updateToDo(toDo)
        }
        toDosCache.removeAll(where: { $0.id == toDo.id })
        toDosCache.append(toDo)
        toDosCache.sort(by: { $0.creationDate > $1.creationDate })
        toDosCache.sort(by: { !$0.isCompleted && $1.isCompleted })
    }
    
    func deleteToDo(_ toDo: ToDo) {
        Task {
            do {
                try await repository.deleteToDo(toDo)
                toDosCache.removeAll { $0.id == toDo.id }
                message = "\(toDo.title) has been deleted!"
                showingMessage = true
            } catch {
                //return []
            }
            
        }
    }
}
