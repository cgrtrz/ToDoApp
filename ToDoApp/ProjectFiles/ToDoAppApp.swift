//
//  ToDoAppApp.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 06/12/2024.
//

import SwiftUI
import CoreData

@main
struct ToDoAppApp: App {
    let persistenceController = PersistenceController.shared
    //let authenticationManager = AuthenticationManager()
    
    var body: some Scene {
        WindowGroup {
            //ContentView()
                
            ToDoListView(isOn: true)
            
            //RootView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(DataManager())
                //.environmentObject(AuthenticationManager())
        }
    }
}
