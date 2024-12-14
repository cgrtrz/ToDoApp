//
//  TaskListView.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 06/12/2024.
//

import SwiftUI

struct ToDoListView: View {
    
    @EnvironmentObject var dataManager: DataManager
    @StateObject var viewModel = ToDoListViewModel()
    
    @State var isOn: Bool
    @State var showingToDos = 0
    @State var selectedItem: Int?
    @State private var showingAddToDoSheet = false
    
    var body: some View {
        
        NavigationStack {
            VStack {
                
                Picker ("", selection: $showingToDos) {
                    ForEach(ToDoListType.allCases, id:\.self) { type in
                        Text(type.name).tag(type.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal, 36)
                .onChange(of: showingToDos) { refreshToDos() }
                
                ZStack {
                    List {
                        ForEach(dataManager.toDos, id: \.self) { toDo in
                            NavigationLink {
                                ToDoDetailView(toDo: toDo)
                            } label: {
                                ToDoRowView(toDo: toDo)
                                    .swipeActions {
                                        Button { dataManager.deleteTask(toDo) }
                                        label: {
                                            VStack {
                                                Image(systemName: "trash")
                                                    .tint(.red)
                                                Text("Delete")
                                            }
                                        }
                                        Button {
                                            Task {
                                                //
                                            }
                                        } label: {
                                            VStack {
                                                Image(systemName: "pencil")
                                                    .tint(.blue)
                                                Text("Edit")
                                            }
                                        }
                                    }
                            }
                        }
                        
                        
                        
                        
                    }
                    .scrollContentBackground(.hidden)
                    if dataManager.isLoading {
                        ProgressView()
                    }
                    Spacer()
                }
                .sheet(isPresented: $showingAddToDoSheet) {
                    AddToDoView()
                        .presentationDetents([.large])
                        .presentationDragIndicator(.visible)
                        .presentationCornerRadius(12)
                }
                .navigationTitle("To-Do-Tasks")
                .toolbar {
                    ToolbarItem (placement: .bottomBar) {
                        Button {
                            showingAddToDoSheet = true
                        } label: {
                            Image(systemName: "plus.circle.fill")
                        }
                    }
                }
            }
        }
    }
    func refreshToDos() {
            dataManager.toDos = []
            dataManager.getToDos(ToDoListType(rawValue: showingToDos) ?? .all)
    }
}
#Preview {
    ToDoListView( isOn: true)
}

