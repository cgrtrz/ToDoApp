//
//  TaskListRowView.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 06/12/2024.
//

import SwiftUI

struct TaskListRowView: View {
    
    @State var task: ToDoTask_
    @StateObject var viewModel = TaskListViewModel()
    
    
    
    var body: some View {
        
        HStack {
            Toggle("some text", isOn: $task.isCompleted)
                .toggleStyle(CompletedTaskToggleStyle())
                .onChange(of: task.isCompleted) { _, _ in
        
                    print("\(task.id.uuidString) state is  \(task.isCompleted)...")
                
                    Task {
                        do {
                            try await viewModel.updateTask(task)
                            print(viewModel.tasks.count)
                            print(viewModel.tasks[viewModel.tasks.firstIndex(of: task) ?? 0])
                        } catch {
                            print("failed.......")
                        }
                    }
                }
            Text(task.title)
                .font(.headline)
                .foregroundStyle(task.isCompleted ? Color.gray :Color.primary)
                .strikethrough(task.isCompleted)
                
                
        }
        
        
    }
}
//
//#Preview {
//    TaskListRowView()
//}
