//
//  Task.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 06/12/2024.
//

import Foundation

struct ToDo : Identifiable, Equatable, Hashable {
    var id: UUID
    var title: String
    var description_: String
    var creationDate: TimeInterval
    var dueDate: TimeInterval?
    var isCompleted: Bool = false
    
    //MARK: - TEST COMMENT
    init(
        id: UUID,
        title: String,
        description: String,
        creationDate: TimeInterval,
        dueDate: TimeInterval,
        isCompleted: Bool
    ) {
        self.id = id
        self.title = title
        self.description_ = description
        self.creationDate = creationDate
        self.dueDate = dueDate
        self.isCompleted = isCompleted
    }
    init(
        title: String,
        description: String,
        creationDate: TimeInterval,
        dueDate: TimeInterval?
    ) {
        self.id = UUID()
        self.title = title
        self.description_ = description
        self.creationDate = creationDate
        self.dueDate = dueDate
        self.isCompleted = false
    }
}


