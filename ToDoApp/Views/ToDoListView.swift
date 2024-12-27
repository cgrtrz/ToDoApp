//
//  TaskListView.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 06/12/2024.
//

import SwiftUI

extension ToDoListView {
    
    
    
    @ViewBuilder
    private func toDoListRowView(_ toDo: ToDo, asdf: Binding<Bool>) -> some View {
        var toDo = toDo
        //val = toDo.isCompleted
        HStack {
            Toggle("some text", isOn: asdf)
                .onChange(of: toDo.isCompleted) { _, _ in
                    if toDo.isCompleted {
                        toDo.completionDate = Date().timeIntervalSince1970
                    } else {
                        toDo.completionDate = 0
                    }
                    viewModel.updateToDo(toDo)
                    
                }
            Text(toDo.title)
                .font(.headline)
                .lineLimit(2)
                .foregroundStyle(toDo.isCompleted ? Color.gray :Color.primary)
                .strikethrough(toDo.isCompleted)
            Spacer()
            Text(!toDo.isCompleted && toDo.hasDueDate && toDo.overdue ? "!" :"")
                .foregroundStyle(Color.red)
            
        }
    }
}

struct ToDoListView: View {
    
    //TODO: Think about DataManager
    //@EnvironmentObject var dataManager: DataManager
    @EnvironmentObject var settingsManager: SettingsManager
    @StateObject var viewModel: ToDoListViewModel = ToDoListViewModel()
    
    @State var ddd: Bool = false
    
    //@Binding var val: Bool
    
    //FIXME: Delete the lines below.
    //@State var isOn: Bool
    //@State var showingToDos = 0
    //@State var toDoo: ToDo?
    @State var rotateGear: Int = .zero
    
    //FIXME: Set ToDoListType from UserDefaults
    @State var selectedToDoListType: ToDoListType = .all //No need
    //@State var selectedItem: Int?
    
    //Sheets
    @State private var showingAddToDoSheet = false
    @State private var showingSettingsSheet = false
    
    //FIXME: Find a viable solution.
    //Being used to show popup.
    @State var message = ""
    @State var showingMessage = false {
        didSet {
            if showingMessage == true {
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    showingMessage = false
                }
            }
        }
    }
    
    
    var body: some View {
        
        NavigationStack {
            VStack {
                //MARK: - HEADER
                HStack{
                    Image("icon")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                    Text("To Do App")
                        .font(.largeTitle)
                        .bold()
                        .foregroundStyle(settingsManager.settings.selectedTheme.colors.tintColor)
                    //Spacer()
                }
                //MARK: - TODOLISTTYPE PICKER
                .padding(.horizontal, 36)
                Picker ("", selection: $viewModel.selectedToDoListType) {
                    ForEach(ToDoListType.allCases, id:\.self) { type in
                        Text(type.name).tag(type.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                .foregroundStyle(settingsManager.settings.selectedTheme.colors.tintColor)
                .padding(.horizontal, 36)
                //.onChange(of: viewModel.selectedToDoListType) { refreshToDos() }
                
                //ZStack to switch between ProgressView and ListView...
                ZStack {
                    //Main ListView
                    List {
                        
                        //FIXME: Reeconsider how to show active and completed ToDos seperately. This is not an effective way.
                        if !viewModel.toDos.filter({!$0.isCompleted}).isEmpty {
                            //Active ToDos section...
                             Section(header: Text("Active")) {
                                 ForEach(viewModel.toDos, id: \.self) { toDo in
                                    
                                     if !toDo.isCompleted {
                                         NavigationLink {
                                             ToDoDetailView(toDo: toDo)
                                         } label: {
                                             ToDoRowView(toDo: toDo, vm: viewModel)
                                             
                                             
                                         }
                                     }
                                 }
                                 .onDelete { indexSet in
                                     if let index = indexSet.first {
                                         viewModel.deleteToDo(viewModel.toDos[index])
                                     }
                                     
                                 }
                             }//Active ToDos section...
                        } //if condition to make sure there is/are active todos
                       
                        if !viewModel.toDos.filter({$0.isCompleted}).isEmpty {
                            //Completed ToDos section...
                            Section(header: Text("Completed")) {
                                
                                //ToDos are loading...
                                ForEach(viewModel.toDos, id: \.self) { toDo in
                                    if toDo.isCompleted { //To populate comp;eted ToDos
                                        NavigationLink {
                                            ToDoDetailView(toDo: toDo)
                                        } label: {
                                            ToDoRowView(toDo: toDo, vm: viewModel)
                                        }
                                    }
                                    
                                }
                                .onDelete { indexSet in
                                    if let index = indexSet.first {
                                        viewModel.deleteToDo(viewModel.toDos[index])
                                    }
                                    
                                }
                            }//Completed ToDos section...
                        } //if condition to make sure there is/are completed todos
                        
                    }// List (main ToDo List)
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)//TODO: Reconsider this modifier.
                    .deleteDisabled(false)
                    //FIXME: Set animation
                    //.animation(.linear(duration: 0.01), value: viewModel.toDos.count)
                    
                    
                    //2nd View in ZStack, shown if ToDo list is empty.
                    if viewModel.toDos.isEmpty && !viewModel.isLoading {
                        switch viewModel.selectedToDoListType {
                        case .all:
                            ContentUnavailableView("ToDo List is empty", systemImage: "plus", description: Text("Add new item to your ToDo List"))
                        case .active:
                            ContentUnavailableView("No active ToDo items", systemImage: "plus", description: Text("Add new item to your ToDo List"))
                        case .completed:
                            ContentUnavailableView("No completed ToDo items", systemImage: "plus", description: Text("Add new item to your ToDo List"))
                        }
                        
                    }
                    
                    
                    
                    //3rd View in ZStack, While data is loading, ProgressView rotates...
//                    if viewModel.isLoading {
//                        ProgressView()
//                    }
                    
                    Spacer() //To push content up...
                }//ZStack to switch between ProgressView and ListView...
                //Add New sheet.
                .sheet(isPresented: $showingAddToDoSheet) {
                    AddToDoView(vm: viewModel, showingMessage: $showingMessage, message: $message)
                        .presentationDetents([.large])
                        .presentationDragIndicator(.visible)
                        .presentationCornerRadius(12)
                }
                //Settings sheet.
                .sheet(isPresented: $showingSettingsSheet) {
                    //TODO: Decide how to present settings sheet.
                    SettingsView()
                        .presentationDetents([.large])
                        .presentationDragIndicator(.visible)
                        .presentationCornerRadius(12)
                        .presentationCompactAdaptation(.fullScreenCover)
                }
                
                //Seetings and Add New Buttons
                HStack {
//                    Button {
//                        showingSettingsSheet = true
                    NavigationLink {
                        SettingsView()
                    } label: {
                        ZStack {
                            Capsule(style: .circular)
                                .stroke(settingsManager.settings.selectedTheme.colors.tintColor)
                            HStack {
                                //FIXME: Review animation.
                                Image(systemName: "gearshape.fill")
                                    .font(.title)
                                    .symbolEffect(.rotate, value: rotateGear)
                                Text("Settings")
                                    .font(.title3)
                                Spacer()
                            }
                            .foregroundStyle(settingsManager.settings.selectedTheme.colors.tintColor)
                            .padding()
                        }
                        .frame(width: nil, height: 65)
                        .padding()
                    }
                    //.hoverEffect(.highlight)
//                    .onContinuousHover { _ in
//                        rotateGear = 10
//                    }
//                    .onHover { a in
//                        print("\(a.description)")
//                        if a {
//                            rotateGear = 10
//                        }
//                        
//                    }
                    
                    //Button {
                        //showingAddToDoSheet = true
                        NavigationLink(destination:
                            AddToDoView(vm: viewModel, showingMessage: $showingMessage, message: $message)
                        ) {
                            ZStack {
                                Capsule(style: .circular)
                                    .stroke(settingsManager.settings.selectedTheme.colors.tintColor)
                            HStack {
                                Spacer()
                                Text("Add new")
                                    .font(.title3)
                                Image(systemName: "plus.circle.fill")
                                    .font(.title)
                        }
                            .foregroundStyle(settingsManager.settings.selectedTheme.colors.tintColor)
                            .padding()
                            }
                            .frame(width: nil, height: 65)
                            .padding()
                        
                    }
                        
                }//HStack for Seetings and Add New buttons.
            }//Outer VStack
        }//NavigationStack
        .overlay {
            if showingMessage {
                withAnimation(.interactiveSpring()) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(Color(.secondarySystemBackground))
                        Text(message)
                    }.frame(width: UIScreen.main.bounds.width * 0.75, height: UIScreen.main.bounds.height * 0.085)
                        .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height - 200)
                }
            }
        }//overlay, showing popup after addition and deletion.
        .accentColor(settingsManager.settings.selectedTheme.colors.tintColor)
        .onAppear {
            viewModel.selectedToDoListType = settingsManager.settings.selectedToDoListType
        }
    }
    
    func refreshToDos() {
//            dataManager.toDos = []
//            dataManager.getToDos(ToDoListType(rawValue: showingToDos) ?? .all)
        
        //viewModel.toDos = []
        //viewModel.getToDos()
    }
}
#Preview {
    ToDoListView().environmentObject(DataManager())
        
}

