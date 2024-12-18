//
//  AppleAuthenticationRepository.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 17/12/2024.
//

import Foundation

final class AppleAuthenticationRepository: AuthenticationRepository {
    
    func authenticateUser(username: String, password: String) -> Result<User, any Error> {
        return .success(User(username: "username"))
    }
    
    func createUser(username: String, password: String) throws {
        //
    }
    
    
}
