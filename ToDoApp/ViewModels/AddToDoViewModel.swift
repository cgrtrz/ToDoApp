//
//  AddTaskViewModel.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 14/12/2024.
//

import Foundation

@MainActor
final class AddToDoViewModel: ObservableObject {
    
    private var toDo: ToDo?
    private var dataManager: DataManager = DataManager()
    
//    func addNewTask(title toDoTitle: String, description toDoDescription: String?, dueDate toDoDueDate: TimeInterval?, addedToCalendar: Bool) async {
//        toDo = ToDo(id: UUID(), title: toDoTitle, description: toDoDescription ?? "", creationDate: Date().timeIntervalSince1970, completionDate: 0, dueDate: Date().timeIntervalSince1970, isCompleted: false, addedToCalendar: addedToCalendar)
//        if let task = toDo {
//            do {
//                //try await repository.addToDo(task)
//            } catch {
//                print(error)
//            }
//        }
//    }
    
    func addToDo(_ toDo: ToDo) {
        dataManager.addToDo(toDo)
    }
    
    
    
    
}
