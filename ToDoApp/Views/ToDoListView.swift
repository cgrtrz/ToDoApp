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
    @State private var showingSettingsSheet = false
    @State var showingMessage = false
    @State var message = ""
    
    var body: some View {
        
        NavigationStack {
            VStack {
                HStack{
                    Image("icon")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 40, height: 40)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    Text("To-Do-Tasks")
                        .font(.largeTitle)
                        .bold()
                        .foregroundStyle(Theme.headerColor)
                    Spacer()
                }
                .padding(Constants.pad)
                Picker ("", selection: $showingToDos) {
                    ForEach(ToDoListType.allCases, id:\.self) { type in
                        Text(type.name).tag(type.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                .foregroundStyle(.purple)
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
                                        Button {
                                            dataManager.deleteToDo(toDo)
                                            message = "\(toDo.title) deleted"
                                            withAnimation{
                                                showingMessage = true
                                            }
                                        }
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
                    AddToDoView( showingMessage: $showingMessage, message: $message)
                        .presentationDetents([.large])
                        .presentationDragIndicator(.visible)
                        .presentationCornerRadius(12)
                }
                .sheet(isPresented: $showingSettingsSheet) {
                    SettingsView()
                        .presentationDetents([.large])
                        .presentationDragIndicator(.visible)
                        .presentationCornerRadius(12)
                }
                //.navigationTitle("To-Do-Tasks")
                
                .toolbar {
//                    ToolbarItem (placement: .principal) {
//                        Text("To-Do-Tasks")
//                            .font(.largeTitle)
//                            .bold()
//                            .foregroundStyle(.purple)
//                    }
//                    ToolbarItem (placement: .bottomBar) {
//                        Button {
//                            showingAddToDoSheet = true
//                        } label: {
//                            Image(systemName: "plus.circle.fill")
//                        }
//                    }
                }
                HStack {
                    Button {
                        showingSettingsSheet = true
                    } label: {
                        HStack {
                            Image(systemName: "gearshape.fill")
                                .font(.title)
                            Text("Settings")
                                .font(.title3)
                            Spacer()
                        }
                        .foregroundStyle(.purple)
                        .padding()
                    }
                    
                    Button {
                        showingAddToDoSheet = true
                    } label: {
                        HStack {
                            Spacer()
                            Text("Add new")
                                .font(.title3)
                            Image(systemName: "plus.circle.fill")
                                .font(.title)
                        }
                        .foregroundStyle(.purple)
                        .padding()
                    }
                }
            }
        }
        .overlay {
            MessageView(message: $message, isVisible: $showingMessage)
        }
    }
    
    func refreshToDos() {
            dataManager.toDos = []
            dataManager.getToDos(ToDoListType(rawValue: showingToDos) ?? .all)
    }
}
#Preview {
    ToDoListView( isOn: true).environmentObject(DataManager())
        
}

