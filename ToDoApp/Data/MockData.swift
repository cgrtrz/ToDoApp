//
//  MockTasksData.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 06/12/2024.
//

import Foundation

struct MockData {
    
    let tasks: [Task]
    init() {
        tasks = [
            Task(title: "Task 1", description: "Task 1 description", creationDate: Date().timeIntervalSince1970, dueDate: Date().timeIntervalSince1970, isCompleted: false),
            Task(title: "Task 2", description: "Task 2 description", creationDate: Date().timeIntervalSince1970, dueDate: Date().timeIntervalSince1970, isCompleted: true),
            Task(title: "Task 3", description: "Task 3 description", creationDate: Date().timeIntervalSince1970, dueDate: Date().timeIntervalSince1970, isCompleted: false),
            Task(title: "Task 4", description: "Task 4 description", creationDate: Date().timeIntervalSince1970, dueDate: Date().timeIntervalSince1970, isCompleted: false),
            Task(title: "Task 5", description: "Task 5 description", creationDate: Date().timeIntervalSince1970, dueDate: Date().timeIntervalSince1970, isCompleted: true),
            Task(title: "Task 6", description: "Task 6 description", creationDate: Date().timeIntervalSince1970, dueDate: Date().timeIntervalSince1970, isCompleted: true)]
            }
}
