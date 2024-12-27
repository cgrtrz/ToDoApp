//
//  RootView.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 20/12/2024.
//

import SwiftUI

struct RootView: View {
    
    @EnvironmentObject var authManager: AuthenticationManager
    
    var body: some View {
        if authManager.isUserAuthenticated == .signedIn {
            ToDoListView()
        } else {
            LoginView()
        }
    }
}

#Preview {
    RootView()
}
