//
//  TaskListViewModel.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 06/12/2024.
//

import Foundation
import SwiftUI

enum ToDoListType : Int, CaseIterable {
    case all = 0
    case active = 1
    case completed = 2
    
    var name: String {
        switch self {
        case .all: return "All"
        case .active: return "Active"
        case .completed: return "Completed"
        }
    }
}

@MainActor
final class ToDoListViewModel : ObservableObject {
    
    @Published var toDos: [ToDo] = []
    @Published var isLoading: Bool = false
    
    //var toDoListType: ToDoListType = .all
    
    private var dataManager: DataManager = DataManager()
    
    
    init(){
        
        self.getToDos(.all)
        
    }
    
    
    
    func getToDos(_ type: ToDoListType) {
        isLoading = true
        toDos = []
        Task {
            toDos = await dataManager.getToDos2(type)
            isLoading = false
        }
    }
        
    func addToDo(_ toDo: ToDo)async throws -> Void {
        dataManager.addToDo(toDo)
    }
    
    func updateToDo(_ toDo: ToDo)async throws -> Void {
        dataManager.updateToDo(toDo)
    }
    
    func deleteToDo(_ toDo: ToDo) {
        Task {
            
            let aaa = dataManager.deleteToDo(toDo)
            await print(aaa.value.count)
            getToDos(.all)
        }
        
    
    }
}
