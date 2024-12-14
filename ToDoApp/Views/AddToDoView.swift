//
//  AddTaskView.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 13/12/2024.
//

import SwiftUI

struct AddToDoView: View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var dataManager: DataManager
    
    @State private var title: String = ""
    @State private var descr: String = ""
    @State private var dueDate: Date = Date()
    @State private var showingDatePicker: Bool = false
    @StateObject private var viewModel = AddToDoViewModel()
    //@Binding var showAddTaskSheet: Bool
    
    var body: some View {
        NavigationStack {
            VStack (alignment: .center){
                Form {
                    TextField("**Title**", text: $title)
                        .font(.title)
                        .bold()
                    TextField("Description", text: $descr, axis: .vertical)
                        .lineLimit(6)
                    if showingDatePicker == false {
                        Toggle(isOn: $showingDatePicker) {
                            Text("Set Due Date")
                        }
                    } else  {
                        DatePicker("Due Date", selection: $dueDate)
                            .datePickerStyle(.graphical)
                    }
                    Button {
                        dataManager.addToDo(ToDo(id: UUID(), title: title, description: descr, creationDate: Date().timeIntervalSince1970, dueDate: dueDate.timeIntervalSince1970, isCompleted: false))
                        //dataManager.getToDos(.all)
                            dismiss()
                        
                    } label : {
                        Text("Add Task")
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .disabled(title.isEmpty)
                }
                .scrollContentBackground(.hidden)
                .toolbar {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
                .navigationTitle("New task")
            }
        }
    }
}

#Preview {
    AddToDoView()
}
