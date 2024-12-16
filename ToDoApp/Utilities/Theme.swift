//
//  Theme.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 16/12/2024.
//

import SwiftUI

protocol ThemeStandards {
    
    static var backgroundColor: Color { get }
    static var textColor: Color { get }
    static var headerColor: Color { get }
    static var buttonColor: Color { get }
    static var tintColor: Color { get }
}

final class Theme: ThemeStandards {
    
    static let backgroundColor: Color = Color(.systemBackground)
    static let textColor: Color = Color(.label)
    static let headerColor: Color = Color(.systemPurple)
    static let buttonColor: Color = Color.purple
    static let tintColor: Color = Color.purple
    
    struct Default: ThemeStandards {
        
        static let backgroundColor: Color = Color(.systemBackground)
        static let textColor: Color = Color(.label)
        static let headerColor: Color = Color(.systemPurple)
        static let buttonColor: Color = Color.purple
        static let tintColor: Color = Color.purple
    }
    
    //PopUp Screen -> MessageView
    struct PopUp: ThemeStandards {
        
        static let backgroundColor: Color = Color(.secondarySystemBackground)
        static let textColor: Color = Color(.label)
        static let headerColor: Color = Color.white
        static let buttonColor: Color = Color.purple
        static let tintColor: Color = Color.purple
        
        
    }
    
}
