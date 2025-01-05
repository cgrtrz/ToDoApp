//
//  MainListView.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 05/01/2025.
//
import SwiftUI

struct MainListView: View {
    
    @EnvironmentObject var dataManager: DataManager
    
    var body: some View {
        
        List {
            
            ForEach(dataManager.toDosCache, id: \.self) { toDo in
                
                NavigationLink {
                    ToDoDetailView2(toDo)
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
        //.animation(.interactiveSpring(duration: 0.1))
    }
}
