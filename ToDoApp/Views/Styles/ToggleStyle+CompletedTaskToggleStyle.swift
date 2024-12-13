//
//  ToggleStyle+CompletedTaskToggleStyle.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 06/12/2024.
//

import Foundation
import SwiftUI


struct CompletedTaskToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        return HStack {
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "checkmark.circle")
                .foregroundStyle(configuration.isOn ? Color.green : Color.gray)
                .frame(width: 24, height:24)
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        }
    }
}
