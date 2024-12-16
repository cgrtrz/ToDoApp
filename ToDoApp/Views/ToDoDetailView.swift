//
//  TaskDetailView.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 06/12/2024.
//

import SwiftUI

struct ToDoDetailView: View {
    
    @State var toDo: ToDo
    @State private var dueDate: Date = Date()
    @State private var isEditing: Bool = false
    
    var body: some View {
        NavigationView {
            VStack (alignment: .leading){
                TextEditor(text: $toDo.title)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .disabled(!isEditing)
                TextEditor(text: $toDo.description_)
                    .fontWeight(.semibold)
                    .disabled(!isEditing)
                DatePicker("Due date", selection: $dueDate)
                    .fontWeight(.semibold)
                    //.background(Color(UIColor.systemBackground), in: Rectangle())
                    
                    
                if isEditing {
                    
//                    TextField(toDo.title, text: $toDo.title)
//                        .font(.largeTitle)
//                        .fontWeight(.semibold)
//                    TextField(toDo.description_, text: $toDo.description_)
//                        .fontWeight(.semibold)
//                    Text("\(Date(timeIntervalSince1970: toDo.dueDate ?? 0).formatted(date: .abbreviated, time: .standard))")
//                        .fontWeight(.semibold)
//                    Button {
//                    } label: {
//                        ZStack {
//                            RoundedRectangle(cornerRadius: 4)
//                                .foregroundStyle(Color.blue)
//                            Text("Update Task")
//                                .foregroundStyle(Color.white)
//                                .fontWeight(.semibold)
//                        }
//                        .frame(height: 36, alignment: .center)
//                    }
                }
                else {
                    Text(toDo.title)
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                    Text(toDo.description_)
                        .fontWeight(.semibold)
                    DatePicker("Due date", selection: $dueDate)
                        .fontWeight(.semibold)
                }
                Spacer()
            }
            //.navigationTitle(!isEditing ? task.title : "")
            .padding()
            .toolbar {
                ToolbarItem {
                    Button {
                        isEditing.toggle()
                    } label: {
                        HStack {
                            Image(systemName: "pencil.circle.fill")
                            Text("Edit")
                        }
                        
                    }
                }
            }
        }
    }
}

#Preview {
    ToDoDetailView(toDo: ToDo(title: "Title", description: "Description", creationDate: 0, dueDate: nil))
}
