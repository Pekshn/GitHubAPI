//
//  Owner.swift
//  GitHubAPI
//
//  Created by Petar  on 21.3.25..
//

struct Owner: Codable {
    
    //MARK: - Properties
    let name: String
    
    //MARK: - Coding Keys
    enum CodingKeys: String, CodingKey {
        case name = "login"
    }
}
