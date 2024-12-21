//
//  AuthenticationManager.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 17/12/2024.
//

import Foundation

enum AuthState {
    case undefined
    case signedIn
    case signedOut
}

final class AuthenticationManager: ObservableObject {
    
    private let repository = RepositoryManager.shared.getAuthenticationRepository()

    @Published var user: User?
    @Published var error: Error?
    @Published var isUserAuthenticated: AuthState = .undefined
    
    init() { }
   
    func authenticate(_ username: String, with password: String) {
        let result = repository.authenticateUser(username: username, password: password)
        switch result {
        case .success(let user):
            self.user = user
            self.isUserAuthenticated = .signedIn
        case .failure(let error):
            self.error = error
            self.isUserAuthenticated = .signedOut
        }
        
    }
    
}
