//
//  AddTaskView.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 13/12/2024.
//

import SwiftUI

enum FocusableField: Hashable {
    case title
    case descr
}


struct AddToDoView: View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var dataManager: DataManager
    private let eventManager = EventManager()
    
    @State private var title: String = ""
    @State private var descr: String = ""
    @State private var dueDate: Date = Date()
    @State private var showingDatePicker: Bool = false
    @State private var addToCalendar: Bool = false
    @StateObject private var viewModel = AddToDoViewModel()
    @FocusState private var focus: FocusableField?
    @Binding var showingMessage: Bool
    @Binding var message: String
    //@Binding var showAddTaskSheet: Bool
    
    var body: some View {
        NavigationStack {
            VStack (alignment: .center){
                Form {
                    TextField("**Title**", text: $title)
                        .font(.title)
                        .bold()
                        .focused($focus, equals: .title)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                focus = .title
                            }
                        }
                        
                    TextField("Description", text: $descr, axis: .vertical)
                        .lineLimit(6)
                        .fontWeight(.semibold)
                        .focused($focus, equals: .descr)
                    if showingDatePicker == false {
                        Toggle(isOn: $showingDatePicker)
                            {
                            Text("Set Due Date?")
                                
                        }
                            .tint(.purple)
                    } else  {
                        DatePicker("Due Date", selection: $dueDate)
                            .datePickerStyle(.graphical)
                            .tint(.purple)
                    }
                    Toggle("Add to calendar?", isOn: $addToCalendar)
                        .disabled(!showingDatePicker)
                        .tint(.purple)
                    Button {
                        let newToDo = ToDo(id: UUID(),
                                           title: title,
                                           description: descr,
                                           creationDate: Date().timeIntervalSince1970,
                                           dueDate: dueDate.timeIntervalSince1970,
                                           isCompleted: false)
                        dataManager.addToDo(newToDo)
                        if addToCalendar {
                            do {
                                try eventManager.addToCalendar(newToDo)
                            } catch {
                                print(error)
                            }
                        }
                            dismiss()
                        message = "Task added!"
                        showingMessage = true
                        
                    } label : {
                        Text("Add Task")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .bold()
                            .padding(.horizontal, 8)
                    }
                    .disabled(title.isEmpty)
                    .buttonBorderShape(.roundedRectangle)
                    .buttonStyle(.borderedProminent)
                    .tint(.purple)
                }
                .scrollContentBackground(.hidden)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Add new")
                            .foregroundStyle(.purple)
                            .font(.title2)
                            .bold()
                    }
                    ToolbarItem (placement: .topBarTrailing) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .font(.title2)
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(.white, .purple)
                                .bold()
                                .padding()
                        }
                    }
                    
                }
                //.navigationTitle("New task")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

#Preview {
    AddToDoView(showingMessage: .constant(false), message: .constant(""))
}
