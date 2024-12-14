//
//  AddTaskView.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 13/12/2024.
//

import SwiftUI

struct AddTaskView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var title: String = ""
    @State private var descr: String = ""
    @State private var dueDate: Date = Date()
    
    var body: some View {
        VStack (alignment: .center){
            Form {
                TextField("**Title**", text: $title)
                    .font(.title)
                    .bold()
                TextField("Description", text: $descr, axis: .vertical)
                    .lineLimit(6)
                    
                DatePicker("Due Date", selection: $dueDate)
                    .datePickerStyle(.graphical)
                Button {
                    
                } label : {
                    Text("Add Task")
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
        }
    }
}

#Preview {
    AddTaskView()
}
