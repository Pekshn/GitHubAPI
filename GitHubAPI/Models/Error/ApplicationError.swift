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
