//
//  TaskListView.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 06/12/2024.
//

import SwiftUI

struct TaskListView: View {
    
    @StateObject var viewModel = TaskListViewModel()
    @State var isOn: Bool
    @State var showingTasks = 0
    @State var selectedItem: Int?
    @State private var showAddTaskSheet = false
    
    var body: some View {
        
        
        
        VStack {
            Picker(selection: $showingTasks, label: Text("All")) {
                Text("All").tag(0)
                Text("Incomplete").tag(1)
                Text("Completed").tag(2)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, 36)
            .onChange(of: showingTasks) { _, newValue in
                Task {
                    viewModel.tasks = []
                    await viewModel.getTasks(TaskListType(rawValue: newValue) ?? .all)
                }
                
            }
            ZStack {
            List(selection: $selectedItem) {
                    ForEach(viewModel.tasks) { task in
                        TaskListRowView(task: task)
                    }
                }
                if viewModel.isLoading {
                    ProgressView()
                }
                
            }
            Spacer()
            Button {
                showAddTaskSheet = true
            } label: {
                Image(systemName: "plus")
            }
        }
        .sheet(isPresented: $showAddTaskSheet) {
            AddTaskView()
                .presentationDetents([.large])
                .presentationDragIndicator(.visible)
                .presentationCornerRadius(12)
        }
        
        
    }
}

#Preview {
    TaskListView( isOn: true)
}

