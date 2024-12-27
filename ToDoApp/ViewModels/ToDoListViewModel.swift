//
//  TaskListViewModel.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 06/12/2024.
//

import Foundation
import SwiftUI

//FIXME: Seperate enum to another file.
enum ToDoListType : Int, CaseIterable, Codable {
    
    case all = 0
    case active = 1
    case completed = 2
    
    var name: LocalizedStringKey {
        switch self {
        case .all: return "All"
        case .active: return "Active"
        case .completed: return "Completed"
        }
    }
}

@MainActor
final class ToDoListViewModel : ObservableObject {
    
    //Data Manager
    private var dataManager: DataManager = DataManager()
    
    //Publish these so that views can use.
    @Published var toDos: [ToDo] = [] //ToDos that view shows.
    {
        didSet {
            print("something changed... \(toDos.count)")
            
        }
    }
    @Published var isLoading: Bool = false //To rotate ProgressView while data is loading.
    
    //Whenever selectedToDoListType changes, refresh ToDos array.
    var selectedToDoListType: ToDoListType {
        didSet {
            print("selectedToDoListType has been changed to \(selectedToDoListType.name)")
            getToDos()
        }
    }
    
    init() {
        
        //TODO: Set UserDefault keeps settings including selectedToDoListType by default.
        self.selectedToDoListType = .all  //FIXME: Set ToDoListType from UserDefaults
        
        //FIXME: Set ToDoListType from UserDefaults
        self.getToDos()
        print("viewModel instantiated")
        
    }
    
    //Get ToDos from DataManager and assign them to ToDos Array.
    func getToDos() { // Always track the current selectedToDoListType
        isLoading = true //View shows ProgressView
        print("started......")
        //FIXME: Check this line.
        toDos = []
        
        Task {
            toDos = await dataManager.getToDos2(selectedToDoListType)
            isLoading = false //After ToDos are assigned to array, ProgressView disappears.
        }
    }
        
    func addToDo(_ toDo: ToDo) {
        Task {
            dataManager.addToDo(toDo)
             getToDos()
        }
    }
    
    func updateToDo(_ toDo: ToDo) {
        Task {
            dataManager.updateToDo(toDo)
            getToDos()
        }
    }
    
    //FIXME: Reconsider this func
    func deleteToDo(_ toDo: ToDo) {
        Task {
            dataManager.deleteToDo(toDo)
            //await print(aaa.value.count)
            print("deleting......")
            getToDos()
        }
        
    
    }
}
