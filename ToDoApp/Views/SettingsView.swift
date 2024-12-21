//
//  SettingsView.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 16/12/2024.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var authManager: AuthenticationManager
    
    var body: some View {
        VStack{
            Button {
                authManager.isUserAuthenticated = .signedOut
            } label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 12)
                        .frame(width: 280, height: 60)
                        .foregroundStyle(.purple)
                    Text("Sign out")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .bold()
                        .padding(.horizontal, 8)
                        .foregroundStyle(.white)
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}
