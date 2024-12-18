//
//  MockedAuthenticationRepository.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 17/12/2024.
//

import Foundation

final class MockedAuthenticationRepository: AuthenticationRepository {
    
    func authenticateUser(username: String, password: String) -> Result<User, any Error> {
        
        let user = User(username: "username")
        return .success(user)
        
    }
    
    func createUser(username: String, password: String) throws {
        //
    }
    
    
}
