//
//  AddTaskViewModel.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 14/12/2024.
//

import Foundation

final class AddToDoViewModel: ObservableObject {
    
    private var toDo: ToDo?
    private let repository = RepositoryManager.shared.getToDoRepository()
    
    func addNewTask(title toDoTitle: String, description toDoDescription: String?, dueDate toDoDueDate: TimeInterval?) async {
        toDo = ToDo(id: UUID(), title: toDoTitle, description: toDoDescription ?? "", creationDate: Date().timeIntervalSince1970, dueDate: Date().timeIntervalSince1970, isCompleted: false)
        if let task = toDo {
            do {
                try await repository.addToDo(task)
            } catch {
                print(error)
            }
        }
    }
    
    
    
    
}
