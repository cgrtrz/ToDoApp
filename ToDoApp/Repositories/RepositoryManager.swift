//
//  RepositoryFactory.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 12/12/2024.
//

import Foundation

final class RepositoryManager {
    static func make() -> Repository {
        RepositoryImplementation()
    }
}
