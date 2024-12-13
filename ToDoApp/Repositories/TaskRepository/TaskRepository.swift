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
    
    func getTasks(type: TaskListType) async throws -> [ToDoTask]
    func addTask(_ task: ToDoTask) async throws
    func updateTask(_ task: ToDoTask) async throws
    func deleteTask(_ task: ToDoTask) async throws
    
}
