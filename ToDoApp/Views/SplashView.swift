//
//  SplashView.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 15/12/2024.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Color.purple
                .ignoresSafeArea()
            VStack {
                Image("appicon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                Text("ToDo App")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .bold()
            }
            
        }
    }
}

#Preview {
    SplashView()
}
