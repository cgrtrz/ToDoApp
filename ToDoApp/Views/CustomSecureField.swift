//
//  CustomSecureField.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 19/12/2024.
//

import SwiftUI

struct CustomSecureField: View {
    
    enum FieldFocusState {
        case showPasswordField
        case hidePasswordField
    }
    
    @FocusState var focusedField: FieldFocusState?
    @State var isShowingPassword: Bool = false
    @Binding var password: String
    
    var body: some View {
        
        Group {
            if isShowingPassword {
                TextField(password, text: $password)
                    .focused($focusedField, equals: .hidePasswordField)
            } else {
                SecureField("password", text: $password)
                    .focused($focusedField, equals: .showPasswordField)
            }
        }
//        .autocorrectionDisabled(true)
//        .textInputAutocapitalization(.never)
//        .keyboardType(.default)
//        .textContentType(.password)
        .overlay(alignment: .trailing) {
            Image(systemName: isShowingPassword ? "eye.slash" : "eye")
                .foregroundStyle(.gray)
                .onTapGesture {
                    isShowingPassword.toggle()
                    print("tapped")
                }
        }
    }
}

#Preview {
    CustomSecureField(password: .constant(""))
}
