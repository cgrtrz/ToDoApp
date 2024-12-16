//
//  RepositoryFactory.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 12/12/2024.
//

import Foundation

final class RepositoryManager {
    
    static let shared = RepositoryManager()
    
    //Set ToDo repository to inject into the app.
    private let repositoryType: RepositoryType = .coreData
    
    func getToDoRepository() -> ToDoRepository {
        switch repositoryType {
        case .inMemory:
            return InMemoryToDoRepository()
        case .mockedNetwork:
            return MockedNetworkToDoRepository()
        case .coreData:
            return CoreDataToDoRepository()
        }
        
    }
}
