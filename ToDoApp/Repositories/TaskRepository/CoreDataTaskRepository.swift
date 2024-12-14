//
//  CoreDataTaskRepository.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 11/12/2024.
//

import Foundation
import CoreData
import SwiftUI

///Connects ViewModel to Core Data source.
final class CoreDataTaskRepository: TaskRepository {
    
    //TODO: Implement Core Data Repository
    private let context = PersistenceController.shared.container.viewContext

    init () {
            //createMockData()
    }
    
    
    
    
    private let service = CoreDataService()
    
    func getTasks(type: TaskListType) async throws -> [Any] {
        //
        let fetchRequest: NSFetchRequest<ToDoTaskEntity> = ToDoTaskEntity.fetchRequest()
               do {
                   let entities = try context.fetch(fetchRequest)
                   return entities.map { ToDoTask_(id: UUID(uuidString: $0.id ?? "") ?? UUID(), title: $0.title ?? "", description: $0.description_ ?? "", creationDate: TimeInterval($0.creationDate), dueDate: TimeInterval($0.dueDate), isCompleted: $0.isCompleted) }
               } catch {
                   print("Error fetching tasks from Core Data: \(error)")
                   return []
               }
    }
    
    func addTask(_ task: ToDoTask_) async throws {
        let newTask = ToDoTaskEntity(context: context)
        newTask.id = task.id.uuidString
        newTask.title = task.title
        newTask.description_ = task.description_
        newTask.creationDate = Int64(task.creationDate)
        newTask.dueDate = Int64(task.dueDate ?? 0.0)
        newTask.isCompleted = false
        saveContext()
        
    }
    
    func updateTask(_ task: ToDoTask_) async throws {
        let fetchRequest: NSFetchRequest<ToDoTaskEntity> = ToDoTaskEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", task.id.uuidString as CVarArg)
                do {
                    if let entity = try context.fetch(fetchRequest).first {
                        entity.isCompleted = task.isCompleted
                        saveContext()
                    }
                } catch {
                    print("Error updating task: \(error)")
                }
    }
    
    func deleteTask(_ task: ToDoTask_) async throws {
        let fetchRequest: NSFetchRequest<ToDoTaskEntity> = ToDoTaskEntity.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "id == %@", task.id as CVarArg)
                do {
                    if let entity = try context.fetch(fetchRequest).first {
                        context.delete(entity)
                        saveContext()
                    }
                } catch {
                    print("Error deleting task: \(error)")
                }
    }
    
    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Context kaydedilemedi: \(error.localizedDescription)")
        }
    }
    
    func createMockData() {
        let tasks: [ToDoTask_] = [
            ToDoTask_(id: UUID(), title: "Task 1", description: "Task 1 description", creationDate: Date().timeIntervalSince1970, dueDate: Date().timeIntervalSince1970, isCompleted: false),
            
            ToDoTask_(id: UUID(), title: "Task 2", description: "Task 2 description", creationDate: Date().timeIntervalSince1970, dueDate: Date().timeIntervalSince1970, isCompleted: false),
    
            ToDoTask_(id: UUID(), title: "Task 3", description: "Task 3 description", creationDate: Date().timeIntervalSince1970, dueDate: Date().timeIntervalSince1970, isCompleted: false)]
        
        for task in tasks {
            Task {
                try await Task.sleep(for: .seconds(1))
                try await addTask(task)
            }
        }
    }
}
