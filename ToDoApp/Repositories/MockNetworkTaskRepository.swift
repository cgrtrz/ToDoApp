//
//  MockNetworkTaskRepository.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 11/12/2024.
//

import Foundation

final class MockNetworkTaskRepository: TaskRepository {
    
    
    private var tasks: [ToDoTask] = [
        ToDoTask(title: "Task 1", description: "Task 1 description", creationDate: Date().timeIntervalSince1970, dueDate: Date().timeIntervalSince1970),
        ToDoTask(title: "Task 2", description: "Task 2 description", creationDate: Date().timeIntervalSince1970, dueDate: Date().timeIntervalSince1970),
        ToDoTask(title: "Task 3", description: "Task 3 description", creationDate: Date().timeIntervalSince1970, dueDate: Date().timeIntervalSince1970),
        ToDoTask(title: "Task 4", description: "Task 4 description", creationDate: Date().timeIntervalSince1970, dueDate: Date().timeIntervalSince1970),
        ToDoTask(title: "Task 5", description: "Task 5 description", creationDate: Date().timeIntervalSince1970, dueDate: Date().timeIntervalSince1970),
        ToDoTask(title: "Task 6", description: "Task 6 description", creationDate: Date().timeIntervalSince1970, dueDate: Date().timeIntervalSince1970)]
    
    func getTasks(type: TaskListType) async throws -> [ToDoTask] {
        try await Task.sleep(nanoseconds: NSEC_PER_SEC * 1)
        return tasks
    }
    
    func addTask(_ task: ToDoTask) async throws {
        try await Task.sleep(nanoseconds: NSEC_PER_SEC * 1)
        tasks.append(task)
    }
    
    func updateTask(_ task: ToDoTask) async throws {
        try await Task.sleep(nanoseconds: NSEC_PER_SEC * 1)
        try await deleteTask(task)
        try await addTask(task)
    }
    
    func deleteTask(_ task: ToDoTask) async throws {
        try await Task.sleep(nanoseconds: NSEC_PER_SEC * 1)
        if let index = getArrayIndex(task) {
            tasks.remove(at: index)
        } else {
            throw TaskRepositoryError.taskNotFound
        }
    }
    
    func getArrayIndex(_ task: ToDoTask) -> Int? {
        return tasks.firstIndex(where: { $0.id == task.id })
    }
    
    
}
