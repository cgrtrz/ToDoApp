//
//  TaskRepository.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 11/12/2024.
//

import Foundation

///Works as an interface between data services and VievModels.
///
///Regardless of the source, processes data by means of pre-defined functions.
protocol TaskRepository {
    
    func getToDos(type: ToDoListType) async throws -> [ToDo]
    func addToDo(_ toDo: ToDo) async throws
    func updateToDo(_ toDo: ToDo) async throws
    func deleteToDo(_ toDo: ToDo) async throws
    
}
