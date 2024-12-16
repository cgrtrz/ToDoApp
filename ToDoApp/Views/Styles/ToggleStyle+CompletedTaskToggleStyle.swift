//
//  ToggleStyle+CompletedTaskToggleStyle.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 06/12/2024.
//

import Foundation
import SwiftUI


struct ToDoToogleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        return HStack {
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "checkmark.circle")
                .foregroundStyle(configuration.isOn ? Color.green : Color.gray)
                .frame(width: 32, height:32)
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        }
    }
}

struct CustomDatePicker: DatePickerStyle {
    func makeBody(configuration: Configuration) -> some View {
        return HStack {
            VStack {
                Text("Custom Style")
                DatePicker("MY CUSTOM DESIGN", selection: configuration.$selection)
                    .foregroundStyle(Color.green)
            }
        }
    }
}
