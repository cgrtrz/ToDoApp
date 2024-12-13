//
//  Task.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 06/12/2024.
//

import Foundation

struct ToDoTask_ : Identifiable, Equatable, Hashable {
    let id = UUID()
    var title: String
    let description_: String
    let creationDate: TimeInterval
    var dueDate: TimeInterval?
    var isCompleted: Bool = false
    
    //MARK: - TEST COMMENT
    init(title: String, description: String, creationDate: TimeInterval) {
        self.title = title
        self.description_ = description
        self.creationDate = creationDate
        //self.dueDate = dueDate
        //self.isCompleted = isCompleted
    }
    init(title: String, description: String, creationDate: TimeInterval, dueDate: TimeInterval?) {
        self.title = title
        self.description_ = description
        self.creationDate = creationDate
        self.dueDate = dueDate
        //self.isCompleted = isCompleted
    }
    func test() {
        var task = ToDoTask(title: "Task", description: "Description", creationDate: Date().timeIntervalSince1970)
        task.isCompleted = true
        task.dueDate = Date().timeIntervalSince1970
        task.title = "Updated Task"
        
        //var task2 = ToDoTask()
        
    }
    
}


