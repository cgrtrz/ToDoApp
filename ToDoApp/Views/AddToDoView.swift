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
//    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var dataManager: DataManager
    @EnvironmentObject var settingsManager: SettingsManager
    @StateObject var viewModel: AddToDoViewModel = AddToDoViewModel()
    
    //@ObservedObject var vm: ToDoListViewModel
    
    @FocusState private var focus: FocusableField?
    
    var body: some View {
        NavigationStack {
            VStack (alignment: .center){
                Form {
                    TextField("**Title**", text: $viewModel.title)
                        .font(.title)
                        .bold()
                        .focused($focus, equals: .title)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                focus = .title
                            }
                        }
                        
                    TextField("Description", text: $viewModel.description, axis: .vertical)
                        .lineLimit(6)
                        .fontWeight(.semibold)
                        .focused($focus, equals: .descr)
                    Toggle(isOn: $viewModel.showingDatePicker)
                    {
                        Text("Set Due Date?")
                        
                    }
                        .tint(settingsManager.settings.selectedTheme.colors.tintColor)
                    if viewModel.showingDatePicker {
                        DatePicker("Due Date", selection: $viewModel.dueDate, in: Date().addingTimeInterval(60 * 15)...)
                            .datePickerStyle(.graphical)
                            .tint(settingsManager.settings.selectedTheme.colors.tintColor)
                            .id(Date().addingTimeInterval(60 * 15))
                    }
                    Toggle("Add to calendar?", isOn: $viewModel.addToCalendar)
                        .disabled(!viewModel.showingDatePicker)
                        .tint(settingsManager.settings.selectedTheme.colors.tintColor)
                    Button {
                        viewModel.addNew()
                        dataManager.addToDo(viewModel.newToDo)
                        dismiss()
                    } label : {
                        ButtonLabel(text: "Add", width: nil)
                    }
                    .disabled(viewModel.title.isEmpty)
                }
                .scrollContentBackground(.hidden)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Add new")
                            .foregroundStyle(Constants.gradient)
                            .font(.title2)
                            .bold()
                    }
                }
            }
        }
    }
}

#Preview {
    AddToDoView()
        .environmentObject(SettingsManager())
}
