//
//  LoginView.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 17/12/2024.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
    
    enum Field {
        case username
        case password
    }
    
    @EnvironmentObject var authenticationManager: AuthenticationManager
    
    @FocusState private var focusedField: Field?
    
    @State var username: String = ""
    @State var password: String = ""
    @State var loggedIn: Bool = false
    @State var usernameError: String = ""
    @State var passwordError: String = ""
    @State var showingPassword: Bool = false
    
    var body: some View {
        
        
        NavigationStack {
            ScrollView {
                Spacer()
                Group {
                    Image("icon")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                    Text("To Do App")
                        .foregroundStyle(.purple)
                        .font(.largeTitle)
                } .onTapGesture {
                    hideKeyboard()
                }
                
                CustomLoginView(username: $username, password: $password, usernameError: $usernameError, passwordError: $passwordError)
                    .padding(.horizontal)
                //            Form {
                //                TextField("email", text: $username)
                //                CustomSecureField(password: $password)
                //            }.scrollContentBackground(.hidden)
                HStack {
                    Text("Don't have an account?")
                        .foregroundStyle(Color.secondary)
                    Button("Sign Up") {
                        //
                    }.foregroundStyle(Color.purple)
                }.padding(.bottom, 18)
                
                Button {
                    //TODO: Go to login func
                    print("Logging in...")
                    signIn(username, with: password)
                } label: {
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .frame(width: nil, height: 60)
                            .foregroundStyle(.purple)
                        HStack {
                            Spacer()
                            Image(systemName: "envelope")
                                .font(.title3)
                                .foregroundStyle(Color.white)
                            Text("Sign In with Email")
                            //.frame(alignment: .center)
                                .bold()
                            //.padding(.horizontal, 8)
                                .foregroundStyle(.white)
                            Spacer()
                        }
                    }
                }
                .padding(.horizontal, 20)
                HStack {
                    RoundedRectangle(cornerRadius: 12)
                        .frame(width: nil, height: 1)
                        .foregroundStyle(Color.secondary)
                    Text("OR")
                    RoundedRectangle(cornerRadius: 12)
                        .frame(width: nil, height: 1)
                        .foregroundStyle(Color.secondary)
                }
                //NavigationLink(true, destination: ToDoListView(isOn: true)) {
                Button {
                    //
                } label: {
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            //.stroke(Color.black)
                            .frame(width: nil, height: 60)
                            .foregroundStyle(Color(.label))
                        HStack {
                            Spacer()
                            Image(systemName: "apple.logo")
                                .font(.title)
                                .foregroundStyle(Color(.systemBackground))
                            Text("Sign In with Apple")
                            
                                .bold()
                            //.padding(.horizontal, 8)
                                .foregroundStyle(Color(.systemBackground))
                            Spacer()
                        }
                    }
                }.padding(.horizontal, 20)
                
                Button {
                    //
                } label: {
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray)
                            .frame(width: nil, height: 60)
                            .foregroundStyle(.white)
                        HStack {
                            Spacer()
                            Image("google")
                            Text("Sign In with Google")
                            
                                .bold()
                            //.padding(.horizontal, 8)
                                .foregroundStyle(.gray)
                            Spacer()
                        }
                    }
                }.padding(.horizontal, 20)
        
                Spacer()
                
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .scrollDismissesKeyboard(.immediately)
            
        }
        
    }
    
    func signIn(_ username: String, with password: String) {
        
        hideKeyboard()
        
        if !username.isEmail {
            usernameError = "Enter a valid email..."
        } else {
            usernameError = ""
        }
        
        if password.count < 6 {
            passwordError = "Password must be at least 6 characters..."
        } else {
            passwordError = ""
        }
        if usernameError == "" && passwordError == "" {
            authenticationManager.authenticate(username, with: password)
        }
        
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

#Preview {
    LoginView()
}
