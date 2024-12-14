//
//  TaskDetailView.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 06/12/2024.
//

import SwiftUI

struct TaskDetailView: View {
    
    @State var task: ToDoTask_?
    
    var body: some View {
        Text(task?.title ?? "")
    }
}

#Preview {
    TaskDetailView()
}
