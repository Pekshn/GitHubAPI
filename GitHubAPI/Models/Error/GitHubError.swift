//
//  GitHubError.swift
//  GitHubAPI
//
//  Created by Petar  on 22.3.25..
//

import Foundation

//Error model that GitHub could return
struct GitHubError: Decodable {
    
    //MARK: - Properties
    let message: String
}
