//
//  CoreDataTaskRepository.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 11/12/2024.
//

import Foundation

final  class CoreDataTaskRepository: TaskRepository {
    
    //TODO: Implement Core Data Repository
    
    private let service = CoreDataService()
    
    func getTasks(type: TaskListType) async throws -> [ToDoTask] {
        <#code#>
    }
    
    func addTask(_ task: ToDoTask) async throws {
        <#code#>
    }
    
    func updateTask(_ task: ToDoTask) async throws {
        <#code#>
    }
    
    func deleteTask(_ task: ToDoTask) async throws {
        <#code#>
    }
    
    
}
