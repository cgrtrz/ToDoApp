//
//  TaskDetailView.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 06/12/2024.
//

import SwiftUI

struct ToDoDetailView: View {
    
    @EnvironmentObject var settingsManager: SettingsManager
    @State var toDo: ToDo
    @State private var dueDate: Date = Date()
    @State private var isEditing: Bool = false
    @State private var date: Date = Date()
    @State private var addToCalendar: Bool = false
    
    var body: some View {
        
        
        NavigationView {
            
            Form {
                Section {
                    TextField("Title", text: $toDo.title, axis: .vertical)
                        .font(.largeTitle)
                        .multilineTextAlignment(.leading)
                        .lineLimit(10)
                    TextField("Description", text: $toDo.description_, axis: .vertical)
                        .lineLimit(2...)
                    //Divider()
                    if toDo.addedToCalendar {
                        HStack {
                            Image(systemName: "bell.fill")
                                .foregroundStyle(.yellow)
                                .foregroundStyle(Color.gray)
                                .frame(width: 32, height:32)
                            Text("Added to calendar")
                                .font(.caption)
                                .italic()
                                .foregroundStyle(Color(.secondaryLabel))
                            Spacer()
                            Button("Remove") {
                                //
                            }
                            .underline()
                            .buttonStyle(.borderless)
                            .tint(Color.red)
                        }
                    }
                    
                    HStack {
                        Image(systemName: "pencil")
                            .foregroundStyle(Color.gray)
                            .frame(width: 32, height:32)
                        Text("Created on \(Date(timeIntervalSince1970: toDo.creationDate).formatted(date: .abbreviated, time: .shortened))")
                            .font(.caption)
                            .italic()
                            .foregroundStyle(Color(.secondaryLabel))
                    }
                    if toDo.completionDate != 0 {
                        HStack {
                            Image(systemName:  "checkmark.circle.fill")
                                .foregroundStyle(Color.green)
                                .frame(width: 32, height:32)
                            Text("Completed on \(Date(timeIntervalSince1970: toDo.completionDate ?? 0).formatted(date: .abbreviated, time: .shortened))")
                                .font(.caption)
                                .italic()
                                .foregroundStyle(Color(.secondaryLabel))
                        }
                    }
                }
                Section {
                    if toDo.dueDate != 0 {
                        HStack{
                            Image(systemName: "calendar")
                            Text("Due date")
                            Spacer()
                            DatePicker("", selection: $date)
                                .datePickerStyle(.compact)
                            Text(!toDo.isCompleted && toDo.hasDueDate && toDo.overdue ? "!" : "")
                                .foregroundStyle(.red)
                                .bold()
                        }
                        if !toDo.addedToCalendar {
                            HStack {
                                Image(systemName: "bell.fill")
                                    .foregroundStyle(.yellow)
                                Text("Add to Calendar")
                                Spacer()
                                Toggle("", isOn: $addToCalendar)
                                    .tint(settingsManager.settings.selectedTheme.colors.tintColor)
                            }
                        }
                    }
                    
                    
                }
                
                    Button {
                        //
                    } label: {
                        Text("Update Task")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .bold()
                            .padding(.horizontal, 8)
                    }
                    .disabled(toDo.title.isEmpty)
                    .buttonBorderShape(.roundedRectangle)
                    .buttonStyle(.borderedProminent)
                    .tint(settingsManager.settings.selectedTheme.colors.tintColor)

                
            }.onAppear{
                date = Date(timeIntervalSince1970: toDo.dueDate ?? 0)
                    
            }
            
            .navigationBarTitleDisplayMode(.inline)
            
            
            
//            
//            VStack (alignment: .leading){
//                VStack (alignment: .leading){
//                    TextEditor(text: $toDo.title)
//                        .font(.largeTitle)
//                        .lineLimit(0)
//                    TextEditor(text: $toDo.description_)
//                        .lineLimit(3)
//                    Divider()
//                    Text("Created at \(Date(timeIntervalSince1970: toDo.creationDate).formatted(date: .abbreviated, time: .shortened))")
//                        .font(.caption)
//                        .italic()
//                        .foregroundStyle(Color(.secondaryLabel))
//                    
//                   // Spacer()
//                    
//                    
//                    
//                }
//                
//                Spacer()
//                
//                
//                
//                
//                
//                
////                TextEditor(text: $toDo.title)
////                    .font(.largeTitle)
////                    .fontWeight(.semibold)
////                    .disabled(!isEditing)
////                TextEditor(text: $toDo.description_)
////                    .fontWeight(.semibold)
////                    .disabled(!isEditing)
////                DatePicker("Due date", selection: $dueDate)
////                    .fontWeight(.semibold)
//                    //.background(Color(UIColor.systemBackground), in: Rectangle())
//                    
//                    
//             //   if isEditing {
//                    
////                    TextField(toDo.title, text: $toDo.title)
////                        .font(.largeTitle)
////                        .fontWeight(.semibold)
////                    TextField(toDo.description_, text: $toDo.description_)
////                        .fontWeight(.semibold)
////                    Text("\(Date(timeIntervalSince1970: toDo.dueDate ?? 0).formatted(date: .abbreviated, time: .standard))")
////                        .fontWeight(.semibold)
////                    Button {
////                    } label: {
////                        ZStack {
////                            RoundedRectangle(cornerRadius: 4)
////                                .foregroundStyle(Color.blue)
////                            Text("Update Task")
////                                .foregroundStyle(Color.white)
////                                .fontWeight(.semibold)
////                        }
////                        .frame(height: 36, alignment: .center)
////                    }
////                }
////                else {
////                    Text(toDo.title)
////                        .font(.largeTitle)
////                        .fontWeight(.semibold)
////                    Text(toDo.description_)
////                        .fontWeight(.semibold)
////                    DatePicker("Due date", selection: $dueDate)
////                        .fontWeight(.semibold)
////                }
////                Spacer()
//            }
//            //.navigationTitle(!isEditing ? task.title : "")
//            .padding()
//            .toolbar {
//                ToolbarItem {
//                    Button {
//                        isEditing.toggle()
//                    } label: {
//                        HStack {
//                            Image(systemName: "pencil.circle.fill")
//                            Text("Edit")
//                        }
//                        
//                    }
//                }
//            }
            Spacer()
        }
        .ignoresSafeArea()
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    //TODO: Delete ToDo
                } label: {
                    HStack {
                        Text("Delete")
                        Image(systemName: "trash.fill")
                    }.foregroundStyle(.red)
                }
            }
        }
    }
}

#Preview {
    ToDoDetailView(toDo: ToDo(title: "Title", description: "Description", creationDate: 0))
}
