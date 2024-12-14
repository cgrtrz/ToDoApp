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
final class CoreDataToDoRepository: TaskRepository {
    
    //TODO: Implement Core Data Repository
    private let context = PersistenceController.shared.container.viewContext
    

    init () {
            //createMockData()
    }
    
    private let service = CoreDataService()
    
    func getToDos(type: ToDoListType) async throws -> [ToDo] {
        //
        let fetchRequest: NSFetchRequest<ToDoTaskEntity>
        fetchRequest = ToDoTaskEntity.fetchRequest()
        return await context.perform {
            do {
                let entities = try self.context.fetch(fetchRequest)
                return entities.map { ToDo(id: UUID(uuidString: $0.id ?? "") ?? UUID(), title: $0.title ?? "", description: $0.description_ ?? "", creationDate: TimeInterval($0.creationDate), dueDate: TimeInterval($0.dueDate), isCompleted: $0.isCompleted) }
            }
            catch {
                print("Error fetching ToDos from Core Data: \(error)")
                return []
            }
        }
    }
    
    func addToDo(_ toDo: ToDo) async throws {
        let newToDo = ToDoTaskEntity(context: context)
        newToDo.id = toDo.id.uuidString
        newToDo.title = toDo.title
        newToDo.description_ = toDo.description_
        newToDo.creationDate = Int64(toDo.creationDate)
        newToDo.dueDate = Int64(toDo.dueDate ?? 0.0)
        newToDo.isCompleted = false
        saveContext()
        
    }
    
    func updateToDo(_ toDo: ToDo) async throws {
        let fetchRequest: NSFetchRequest<ToDoTaskEntity> = ToDoTaskEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", toDo.id.uuidString as CVarArg)
        await context.perform {
            do {
                if let entity = try self.context.fetch(fetchRequest).first {
                    entity.isCompleted = toDo.isCompleted
                    self.saveContext()
                }
            } catch {
                print("Error updating task: \(error)")
            }
        }
    }
    
    func deleteToDo(_ toDo: ToDo) async throws {
        let fetchRequest: NSFetchRequest<ToDoTaskEntity> = ToDoTaskEntity.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "id == %@", toDo.id as CVarArg)
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
        let toDos: [ToDo] = [
            ToDo(id: UUID(), title: "Task 1", description: "Task 1 description", creationDate: Date().timeIntervalSince1970, dueDate: Date().timeIntervalSince1970, isCompleted: false),
            
            ToDo(id: UUID(), title: "Task 2", description: "Task 2 description", creationDate: Date().timeIntervalSince1970, dueDate: Date().timeIntervalSince1970, isCompleted: false),
    
            ToDo(id: UUID(), title: "Task 3", description: "Task 3 description", creationDate: Date().timeIntervalSince1970, dueDate: Date().timeIntervalSince1970, isCompleted: false)]
        
        for toDo in toDos {
            Task {
                try await Task.sleep(for: .seconds(1))
                try await addToDo(toDo)
            }
        }
    }
}
