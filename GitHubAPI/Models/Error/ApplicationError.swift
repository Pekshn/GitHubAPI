//
//  ApplicationError.swift
//  GitHubAPI
//
//  Created by Petar  on 22.3.25..
//

import Foundation

struct ApplicationError: Error, Identifiable {
    
    //MARK: - Properties
    let id = UUID()
    let message: String
    let statusCode: Int
}

//MARK: - Public API
extension ApplicationError {
    
    static func from(error: Error) -> ApplicationError {
        if let appError = error as? ApplicationError {
            return appError
        } else {
            return ApplicationError(message: error.localizedDescription, statusCode: -1)
        }
    }
}
