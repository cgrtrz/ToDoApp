//
//  ContentView.swift
//  ToDoAppWatchOS Watch App
//
//  Created by Cagri Terzi on 05/01/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            List {
                ForEach(0..<10) {
                    Text("Item \( $0 )")
                }
            }.navigationTitle("ToDo App")
        }
        
    }
}

#Preview {
    ContentView()
}
