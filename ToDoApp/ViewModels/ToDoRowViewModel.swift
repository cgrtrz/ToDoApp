//
//  TaskListRowViewModel.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 06/12/2024.
//

import Foundation


/// Keeps task lists.
///
/// goig nere...
/// - Author: Cagri Terzi
/// - Warning: Be careful to use...
/// - Requires: nothing
/// - Remark: very good struct
/// - Important: really important
final class ToDoRowViewModel : ObservableObject{
    var task: ToDo?
 
    func updateMockData(id: UUID) {
        print("print......")
    }
    
    func new(){
        updateMockData(id: UUID())
    }
}

