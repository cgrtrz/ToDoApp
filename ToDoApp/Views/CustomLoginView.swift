//
//  CustomLoginView.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 20/12/2024.
//

import SwiftUI

struct CustomLoginView: View {
    
    enum FieldFocusState {
        case username
        case hiddenPassword
        case clearPassword
    }
    
    @FocusState var focusableField: FieldFocusState?
    @FocusState var isUsernameFocused: Bool
    @FocusState var isPasswordFocused: Bool
    @FocusState var isHiddenPasswordFocused: Bool
    
    @Binding var username: String
    @Binding var password: String
    @Binding var usernameError: String
    @Binding var passwordError: String
    
    @State var isShowingPassword: Bool = false
    
    var body: some View {
        
        let isUsernameActive = isUsernameFocused //|| username.count > 0
        let isPasswordActive = isPasswordFocused || isHiddenPasswordFocused//|| password.count > 0
        //let usernameError: Bool = !username.isEmail
        
        VStack {
            
            Group {
                TextField("Email", text: $username)
                    .focused($isUsernameFocused)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .textContentType(.username)
                    .keyboardType(.emailAddress)
                    .onTapGesture {
                        isUsernameFocused = true
                    }
                    .onChange(of: username) { _, _ in
                        if usernameError.count > 0 && username.isEmail {
                            usernameError = ""
                        }
                    }
                RoundedRectangle(cornerRadius: 4)
                    .frame(width: nil, height: 1)
                    .foregroundStyle(isUsernameActive ? Color.purple : Color.secondary)
                Text(usernameError.count > 0 ? usernameError : ".")
                    .font(.footnote)
                    .foregroundStyle(usernameError.count > 0 ? Color.red : Color.clear)
            }
    
            Group {
                Group {
                    if isShowingPassword {
                        TextField("Password", text: $password)
                            .focused($isPasswordFocused)
                            .keyboardType(.asciiCapable)
                            .onTapGesture {
                                isPasswordFocused = true
                            }
                            .onChange(of: password) { _, _ in
                                if password.count > 5 {
                                    passwordError = ""
                                }
                            }
                    } else {
                        SecureField("Password", text: $password)
                            .focused($isHiddenPasswordFocused)
                            .onTapGesture {
                                isHiddenPasswordFocused = true
                            }
                            .onChange(of: password) { _, _ in
                                if password.count > 5 {
                                    passwordError = ""
                                }
                            }
                    }
                }
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .keyboardType(.default)
                .textContentType(.password)
                .overlay(alignment: .trailing) {
//                    Button {
//                        isShowingPassword.toggle()
//                        if isHiddenPasswordFocused {
//                            isPasswordFocused = true
//                        } else {
//                            isHiddenPasswordFocused = true
//                        }
//                    } label: {
//                        Image(systemName: isShowingPassword ? "eye.slash" : "eye")
//                            .foregroundStyle(Color.secondary)
//                    }
                    
                    Image(systemName: isShowingPassword ? "eye.slash" : "eye")
                        .foregroundStyle(isPasswordActive ? Color.purple : Color.secondary)
                        .onTapGesture {
                            isShowingPassword.toggle()
                            if isHiddenPasswordFocused {
                                isPasswordFocused = true
                            } else {
                                isHiddenPasswordFocused = true
                            }
                        }
                }
                RoundedRectangle(cornerRadius: 4)
                    .frame(width: nil, height: 1)
                    .foregroundStyle(isPasswordActive ? Color.purple : Color.secondary)
                Text(passwordError.count > 0 ? passwordError : ".")
                    .font(.footnote)
                    .foregroundStyle(passwordError.count > 0 ? Color.red : Color.clear)
            }
            
            
            
/// Animating Rounded Text Field
///----------------------------------------------------------------------------
///
//            Group {
//                ZStack {
//                    TextField("", text: $username)
//                        .padding()
//                        .focused($isUsernameFocused)
//                       
//                    RoundedRectangle(cornerRadius: 18)
//                        .stroke(isUsernameActive ? Color.primary : Color.secondary)
//                        .frame(width: nil, height: 42)
//                        .overlay (alignment: .leading){
//                                    HStack {
//                                        Text("Email")
//                                            .foregroundStyle(isUsernameActive ? Color.primary : Color.secondary)
//                                            .font(isUsernameActive ? .footnote : .callout)
//                                            .padding(.horizontal, 8)
//                                            .background(Color(.systemBackground))
//                                            .padding(.leading, 12)
//                                            .offset(x: 0, y: isUsernameActive ? -20 : 0)
//                                        Spacer()
//                                
//                            }
//
//                        }
//                    
//                        
//                }
//                .onTapGesture {
//                    isUsernameFocused = true
//                }
//                .animation(.linear(duration: 0.1), value: isUsernameFocused)
//                Text("Please enter a valid email...")
//                    .font(.footnote)
//                    .foregroundStyle(Color.red)
//            }
            Group {
                
            }
        }.padding()
    }
}

#Preview {
    CustomLoginView(username: .constant(""), password: .constant(""), usernameError: .constant(""), passwordError: .constant(""))
}
