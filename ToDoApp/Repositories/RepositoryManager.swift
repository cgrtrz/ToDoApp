//
//  RepositoryFactory.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 12/12/2024.
//

import Foundation

final class RepositoryManager {
    
    static let shared = RepositoryManager()
    
    func getTaskRepository() -> TaskRepository {
        return CoreDataToDoRepository()
    }
}
