//
//  TaskListView.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 06/12/2024.
//

import SwiftUI

struct ToDoListView: View {
    
    //TODO: Think about DataManager
    @EnvironmentObject var dataManager: DataManager
    @EnvironmentObject var settingsManager: SettingsManager
    @StateObject var viewModel: ToDoListViewModel = ToDoListViewModel()
    
    //@State var ddd: Bool = false
    
    //FIXME: Delete the lines below.
    //
    
    //FIXME: Set ToDoListType from UserDefaults
    //@State var selectedToDoListType: ToDoListType = .all //No need
    //@State var selectedItem: Int?
    
    //Sheets
    
    
    //FIXME: Find a viable solution.
    //Being used to show popup.
    
    
    
    var body: some View {
        
        NavigationStack {
            VStack {
                //MARK: - HEADER
                HeaderView()
                
                //ZStack to switch between ProgressView and ListView...
                ZStack {
                    List {
                        ForEach(dataManager.toDosCache, id: \.self) { toDo in
                            NavigationLink {
                                ToDoDetailView(toDo: toDo)
                            } label: {
                                ToDoRowView(toDo: toDo)
                            }
                        }
                        .onDelete { indexSet in
                            if let index = indexSet.first {
                                dataManager.deleteToDo(dataManager.toDosCache[index])
                            }
                        }
                        
                    }// List (main ToDo List)
                    .listStyle(.plain)
                    .refreshable {
                        dataManager.getToDos()
                    }
                    .animation(.interactiveSpring)
                    
                    //2nd View in ZStack, shown if ToDo list is empty.
                    if dataManager.toDosCache.isEmpty && !dataManager.isLoading{
                        ContentUnavailableView("ToDo List is empty", systemImage: "plus", description: Text("Add new item to your ToDo List"))
                    }
                    //3rd View in ZStack, While data is loading, ProgressView rotates...
                    if dataManager.isLoading {
                        ProgressView()
                    }
                    
                    Spacer() //To push content up...
                }//ZStack to switch between ProgressView and ListView...
                
                //Settings and Add New Buttons
                HStack {
                    NavigationLink {
                        SettingsView()
                    } label: {
                        ButtonLabel(imageName: "gearshape.fill", text: "Settings", width: nil)
                    }
                    
                    NavigationLink {
                        AddToDoView()
                    } label: {
                        ButtonLabel(imageName: "plus", text: "Add new", width: nil, imagePlacement: .trailing)
                    }
                }//HStack for Seetings and Add New buttons.
            }//Outer VStack
        }//NavigationStack
        .overlay {
            if dataManager.showingMessage {
                MessageView(message: dataManager.message)
            }
        }//overlay, showing popup after addition and deletion.
        //.accentColor(settingsManager.settings.selectedTheme.colors.tintColor)
    }
}

#Preview {
    ToDoListView().environmentObject(DataManager())
        .environmentObject(SettingsManager())
        
}


