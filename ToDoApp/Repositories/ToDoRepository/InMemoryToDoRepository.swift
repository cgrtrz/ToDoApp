//
//  InMemoryTaskRepository.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 11/12/2024.
//

import Foundation

///Creates dummy data in runtime memory.
final class InMemoryToDoRepository: ToDoRepository {
    
    private var toDos: [ToDo] = [
        ToDo(id: UUID(), title: "Task 1", description: "Task 1 description", creationDate: Date().timeIntervalSince1970, completionDate: 0, dueDate: 0, isCompleted: false),
        ToDo(title: "Task 2", description: "Task 2 description", creationDate: Date().timeIntervalSince1970),
        ToDo(id: UUID(), title: "Task 3", description: "Task 3 description", creationDate: Date().timeIntervalSince1970, completionDate: 0, dueDate: 0, isCompleted: true),
        ToDo(title: "Task 4", description: "Task 4 description", creationDate: Date().timeIntervalSince1970),
        ToDo(id: UUID(), title: "Task 5", description: "Task 5 description", creationDate: Date().timeIntervalSince1970, completionDate: 0, dueDate: 0, isCompleted: false),
        ToDo(id: UUID(), title: "Task 6", description: "Task 6 description", creationDate: Date().timeIntervalSince1970, completionDate: 0, dueDate: 0, isCompleted: false)]
    
    func getToDos(type: ToDoListType) async throws -> [ToDo] {
        return toDos
    }
    
    func addToDo(_ toDo: ToDo) async throws {
        toDos.append(toDo)
    }
    
    func updateToDo(_ toDo: ToDo) async throws {
        try await deleteToDo(toDo)
        try await addToDo(toDo)
    }
    
    func deleteToDo(_ toDo: ToDo) async throws {
        if let index = getArrayIndex(toDo) {
            toDos.remove(at: index)
        } else {
            throw TaskRepositoryError.taskNotFound
        }
    }
    
    func getArrayIndex(_ toDo: ToDo) -> Int? {
        return toDos.firstIndex(where: { $0.title == toDo.title })
    }
}


