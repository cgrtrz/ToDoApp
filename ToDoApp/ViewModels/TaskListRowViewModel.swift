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
final class TaskListRowViewModel : ObservableObject{
    var task: ToDoTask_?
    
   
    //MARK: - Updates Mock Data
    /**
     Updates Mock Data.
     
     # New item
     
     1. item
     2. item
     
     - updates
     - mock
     - data
     
     ```
     if (isAwesome){
     return true
     }
     ```
     
     
     
     
     
     conclusion
     - Parameter id: id is a `parameter`
     */
    
    func updateMockData(id: UUID) {
        print("print......")
    }
    
    func new(){
        updateMockData(id: UUID())
    }
}

