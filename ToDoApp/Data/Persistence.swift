//
//  Persistence.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 12/12/2024.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "ToDoApp")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Persistent store yüklenirken hata oluştu: \(error.localizedDescription)")
            }
        }
    }
}
