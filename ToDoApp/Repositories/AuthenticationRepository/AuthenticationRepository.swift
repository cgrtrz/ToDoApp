//
//  AuthenticationRepository.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 12/12/2024.
//

import Foundation



protocol AuthenticationRepository {
    
    func authenticateUser(username: String, password: String) -> Result<User, any Error>
    
    func validateUser(username: String, password: String) -> Bool
    
    func createUser(username: String, password: String) throws
}

extension AuthenticationRepository {
    
    func validateUser(username: String, password: String) -> Bool {
        //TODO: Validate username and password, then return BOOL.
        false
    }
}

final class A : AuthenticationRepository {
    func authenticateUser(username: String, password: String) -> Result<User, any Error> {
        //
        return .success(User(username: ""))
    }
    
    func authenticateUser(username: String, password: String, completion: (Result<User, any Error>)) {
        //
    }
    
    func createUser(username: String, password: String) throws {
        //
    }
    
    
}
