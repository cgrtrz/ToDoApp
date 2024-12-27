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
    @EnvironmentObject var settingsManager: SettingsManager
    @StateObject var viewModel: AddToDoViewModel = AddToDoViewModel()
    
    
    @ObservedObject var vm: ToDoListViewModel
    
    
    private let eventManager = EventManager()
    
    @State private var title: String = ""
    @State private var descr: String = ""
    @State private var dueDate: Date = Date().addingTimeInterval(60 * 15)
    @State private var showingDatePicker: Bool = false
    @State private var addToCalendar: Bool = false
    //@StateObject private var viewModel = AddToDoViewModel()
    @FocusState private var focus: FocusableField?
    @Binding var showingMessage: Bool {
        didSet {
            if showingMessage == true {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    showingMessage = false
                }
            }
        }
    }
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
                    Toggle(isOn: $showingDatePicker)
                        {
                        Text("Set Due Date?")
                            
                    }
                        .tint(settingsManager.settings.selectedTheme.colors.tintColor)
                    if showingDatePicker {
                        DatePicker("Due Date", selection: $dueDate, in: Date().addingTimeInterval(60 * 15)...)
                            .datePickerStyle(.graphical)
                            .tint(settingsManager.settings.selectedTheme.colors.tintColor)
                            .id(Date().addingTimeInterval(60 * 15))
                    }
                    Toggle("Add to calendar?", isOn: $addToCalendar)
                        .disabled(!showingDatePicker)
                        .tint(settingsManager.settings.selectedTheme.colors.tintColor)
                    Button {
                        var newToDo: ToDo
                        if showingDatePicker {
                             newToDo = ToDo(id: UUID(),
                                               title: title,
                                               description: descr,
                                               creationDate: Date().timeIntervalSince1970,
                                            completionDate: 0,
                                               dueDate: dueDate.timeIntervalSince1970,
                                            isCompleted: false, addedToCalendar: addToCalendar)
                        } else {
                            newToDo = ToDo(title: title, description: descr, creationDate: Date().timeIntervalSince1970)
                        }
                        
                        //dataManager.addToDo(newToDo)
                        //viewModel.addToDo(newToDo)
                        vm.addToDo(newToDo)
                        if addToCalendar {
                            do {
                                try eventManager.addToCalendar(newToDo)
                                newToDo.addedToCalendar = true
                                //dataManager.updateToDo(newToDo)
                                //viewModel.updateToDo(newToDo)
                            } catch {
                                print(error)
                            }
                        }
                            dismiss()
                        message = "Task added!"
                        showingMessage = false
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
                    .tint(settingsManager.settings.selectedTheme.colors.tintColor)
                }
                .scrollContentBackground(.hidden)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Add new")
                            .foregroundStyle(settingsManager.settings.selectedTheme.colors.tintColor)
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
                                .foregroundStyle(.white, settingsManager.settings.selectedTheme.colors.tintColor)
                                .bold()
                                //.padding()
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
    AddToDoView(vm: ToDoListViewModel(), showingMessage: .constant(false), message: .constant(""))
}
