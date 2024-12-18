//
//  LoginView.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 17/12/2024.
//

import SwiftUI

struct LoginView: View {
    
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        VStack {
            Spacer()
            Image("icon")
                .resizable()
                .frame(width: 150, height: 150)
                .clipShape(Circle())
            Text("To Do App")
                .foregroundStyle(.purple)
                .font(.largeTitle)
            Group {
                Form {
                    TextField("Email", text: $email)
                    SecureField("Password", text: $password)
                }
                .frame(height: 150)
                .scrollContentBackground(.hidden)
                Button {
                    //
                } label: {
                    Text("Login")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .bold()
                        .padding(.horizontal, 8)
                }
                .buttonBorderShape(.roundedRectangle)
                .buttonStyle(.borderedProminent)
                .tint(.purple)
                .padding(.horizontal, 20)
            }
            //.position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
            Spacer()
        }
    }
}

#Preview {
    LoginView()
}
